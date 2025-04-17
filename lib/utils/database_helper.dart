import 'package:form_application/models/address.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper =
      DatabaseHelper._createInstance();
  static Database? _database;

  factory DatabaseHelper() => _databaseHelper;

  DatabaseHelper._createInstance();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'form_app.db');
    var formDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return formDatabase;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute("PRAGMA foreign_keys = ON;");

    await db.execute('''
      CREATE TABLE personal_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        date_of_birth TEXT NOT NULL,
        gender TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE address (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personal_details_id INTEGER NOT NULL,
        address_line TEXT NOT NULL,
        pin_code TEXT NOT NULL,
        city TEXT NOT NULL,
        state TEXT NOT NULL,
        country TEXT NOT NULL,
        FOREIGN KEY (personal_details_id) REFERENCES personal_details(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE contact_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personal_details_id INTEGER NOT NULL,
        contact_type TEXT NOT NULL,
        contact_value TEXT NOT NULL,
        is_verified INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (personal_details_id) REFERENCES personal_details(id) ON DELETE CASCADE
      )
    ''');
  }

  // fetch operation
  Future<List<Map<String, dynamic>>> getPersonalDetails() async {
    Database db = await database;

    var result = await db.rawQuery('''
      SELECT * FROM personal_details ORDER BY first_name ASC
    ''');
    return result;
  }

  Future<List<Map<String, dynamic>>> getAddress() async {
    Database db = await database;

    var result = db.query('address');
    return result;
  }

  Future<List<Map<String, dynamic>>> getContactDetials() async {
    Database db = await database;

    var result = db.query('contact_details');
    return result;
  }

  Future<List<Map<String, dynamic>>> getPersonalDetailsById(int id) async {
    Database db = await database;

    var result = await db.query(
      'personal_details',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getAddressBypersonalDetailsId(
    int personalDetailsId,
  ) async {
    Database db = await database;

    var result = db.query(
      'address',
      where: 'personal_details_id = ?',
      whereArgs: [personalDetailsId],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getContactDetialsByPersonalDetailsId(
    int personalDetailsId,
  ) async {
    Database db = await database;

    var result = db.query(
      'contact_details',
      where: 'personal_details_id = ?',
      whereArgs: [personalDetailsId],
    );
    return result;
  }


  // Insert operation
  Future<int> insertPersonalDetails(PersonalDetails personalDetails) async {
    Database db = await database;

    var result = await db.insert('personal_details', personalDetails.toMap());
    return result;
  }

  Future<int> insertAddress(Address address) async {
    Database db = await database;

    var result = await db.insert('address', address.toMap());
    return result;
  }

  Future<int> insertContactDetails(ContactDetails contactDetails) async {
    Database db = await database;

    var result = await db.insert('contact_details', contactDetails.toMap());
    return result;
  }

  // Update operations
  Future<int> updatePersonalDetails(PersonalDetails personalDetails) async {
    Database db = await database;

    var result = await db.update(
      'personal_details',
      personalDetails.toMap(),
      where: 'id = ?',
      whereArgs: [personalDetails.id],
    );
    return result;
  }

  Future<int> updateAddress(Address address) async {
    Database db = await database;

    var result = await db.update(
      'address',
      address.toMap(),
      where: 'personal_details_id = ?',
      whereArgs: [address.personalDetailsId],
    );
    return result;
  }

  Future<int> updateContactDetails(ContactDetails contactDetails) async {
    Database db = await database;

    var result = await db.update(
      'contact_details',
      contactDetails.toMap(),
      where: 'personal_details_id = ?',
      whereArgs: [contactDetails.personalDetailsId],
    );
    return result;
  }

  // Delete operations
  Future<int> deletePersonalDetails(int id) async {
    Database db = await database;

    var result = db.delete(
      'personal_details',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}

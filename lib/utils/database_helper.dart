import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _database;

  factory DatabaseHelper() => _databaseHelper;

  DatabaseHelper._createInstance();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'form_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb
    );
  }

  Future<void> _createDb(Database db, int newVersion) async {

    await db.execute('''
      CREATE TABLE personal_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOW NULL,
        date_of_birth TEXT NOT NULL,
        gender TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE address (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personal_details_id INTEGER NOT NULL,
        address_line_1 TEXT NOT NULL,
        address_line_2 TEXT,
        pin_code TEXT NOT NULL,
        city TEXT NOT NULL,
        state TEXT NOT NULL,
        country TEXT NOT NULL,
        FOREIGN KEY (personal_details_id) REFERENCES personal_details(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE contact_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personal_details_id INTEGER NOT NULL,
        contact_type TEXT NOT NULL,
        contact_value TEXT NOT NULL,
        is_verified INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (personal_details_id) REFERENCES personal_details(id)
      )
    ''');
  }

  

}
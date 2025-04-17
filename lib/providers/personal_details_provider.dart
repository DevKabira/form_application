import 'dart:nativewrappers/_internal/vm/lib/developer.dart';
import 'package:flutter/material.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/utils/database_helper.dart';

class PersonalDetailsProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<PersonalDetails> _personalDetailsList = [];
  bool _isLoading = false;

  List<PersonalDetails> get personalDetailsList => _personalDetailsList;
  bool get isLoading => _isLoading;

  Future<void> loadPersonalDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _databaseHelper.getPersonalDetails();
      _personalDetailsList =
          data.map((e) => PersonalDetails.fromMapObject(e)).toList();
    } catch (e) {
      log('Error getting personal details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePersonalDetail(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _databaseHelper.deletePersonalDetails(id);
      _personalDetailsList.removeWhere((item) => item.id == id);
    } catch (e) {
      log('Error Deleting: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

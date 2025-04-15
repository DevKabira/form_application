class PersonalDetails {
  int _id = 0;
  String _firstName = '';
  String _lastName = '';
  String _dateOfBirth = '';
  String _gender = '';


  PersonalDetails(this._firstName, this._lastName, this._dateOfBirth, this._gender);
  PersonalDetails.withId(this._id, this._firstName, this._lastName, this._dateOfBirth, this._gender);
  
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get dateOfBirth => _dateOfBirth;
  String get gender => _gender;

  set firstName(String firstName) => _firstName = firstName;
  set lastName(String lastName) => _lastName = lastName;
  set dateOfBirth(String dateOfBirth) => _dateOfBirth = dateOfBirth;
  set gender(String gender) => _gender = gender;

  Map<String, dynamic> toMap() {

    var map = <String, dynamic>{};
    if (_id != 0){
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['dateOfBirth'] = _dateOfBirth;
    map['gender'] = _gender;

    return map;
  }

  PersonalDetails.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _firstName = map['firstName'];
    _lastName = map['lastName'];
    _dateOfBirth = map['dateOfBirth'];
    _gender = map['gender'];
  }
}
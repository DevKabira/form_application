class PersonalDetails {
  int? id;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? gender;

  PersonalDetails({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
  });
  PersonalDetails.withId({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
  });

  int get getId => id!;
  String get getFirstName => firstName!;
  String get getLastName => lastName!;
  String get getDateOfBirth => dateOfBirth!;
  String get getGender => gender!;

  set setFirstName(String firstName) => this.firstName = firstName;
  set setLastName(String lastName) => this.lastName = lastName;
  set setDateOfBirth(String dateOfBirth) => this.dateOfBirth = dateOfBirth;
  set setGender(String gender) => this.gender = gender;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != 0) {
      map['id'] = id;
    }
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;

    return map;
  }

  PersonalDetails.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    dateOfBirth = map['date_of_birth'];
    gender = map['gender'];
  }
}

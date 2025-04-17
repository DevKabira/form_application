class ContactDetails {
  int? id;
  int? personalDetailsId;
  String? contactType;
  String? contactValue;
  int? isVerified;

  ContactDetails({
    this.personalDetailsId,
    this.contactType,
    this.contactValue,
    this.isVerified,
  });
  ContactDetails.withId({
    this.id,
    this.personalDetailsId,
    this.contactType,
    this.contactValue,
    this.isVerified,
  });

  int get getId => id!;
  int get getPersonalDetailsId => personalDetailsId!;
  String get getContactType => contactType!;
  String get getContactValue => contactValue!;
  int get getIsVerified => isVerified!;

  set setPersonalDetailsId(int personalDetailsId) =>
      this.personalDetailsId = personalDetailsId;
  set setContactType(String contactType) => this.contactType = contactType;
  set setContactValue(String contactValue) => this.contactValue = contactValue;
  set setIsVerified(int isVerified) => this.isVerified = isVerified;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['personal_details_id'] = personalDetailsId;
    map['contact_type'] = contactType;
    map['contact_value'] = contactValue;
    map['is_verified'] = isVerified;
    return map;
  }

  ContactDetails.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    personalDetailsId = map['personal_details_id'];
    contactType = map['contact_type'];
    contactValue = map['contact_value'];
    isVerified = map['is_verified'];
  }

  ContactDetails copyWith({
    int? id,
    int? personalDetailsId,
    String? contactType,
    String? contactValue,
    int? isVerified,
  }) {
    return ContactDetails.withId(
      id: id ?? this.id,
      personalDetailsId: personalDetailsId ?? this.personalDetailsId,
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

class Address {
  int? id;
  int? personalDetailsId;
  String? addressLine;
  String? pinCode;
  String? city;
  String? state;
  String? country;

  Address({
    this.personalDetailsId,
    this.addressLine,
    this.pinCode,
    this.city,
    this.state,
    this.country,
  });
  Address.withId({
    this.id,
    this.personalDetailsId,
    this.addressLine,
    this.pinCode,
    this.city,
    this.state,
    this.country,
  });

  int get getId => id!;
  int get getPersonalDetailsId => personalDetailsId!;
  String get getAddressLine => addressLine!;
  String get getPinCode => pinCode!;
  String get getCity => city!;
  String get getState => state!;
  String get getCountry => country!;

  set setId(int id) => this.id = id;
  set setPersonalDetailsId(int personalDetailsId) =>
      this.personalDetailsId = personalDetailsId;
  set setAddressLine(String addressLine) => this.addressLine = addressLine;
  set setPinCode(String pinCode) => this.pinCode = pinCode;
  set setCity(String city) => this.city = city;
  set setState(String state) => this.state = state;
  set setCountry(String country) => this.country = country;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != 0) {
      map['id'] = id;
      map['personal_details_id'] = personalDetailsId;
      map['address_line'] = addressLine;
      map['pin_code'] = pinCode;
      map['city'] = city;
      map['state'] = state;
      map['country'] = country;
    }

    return map;
  }

  Address.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    personalDetailsId = map['personal_details_id'];
    addressLine = map['address_line'];
    pinCode = map['pin_code'];
    city = map['city'];
    state = map['state'];
    country = map['country'];
  }
}

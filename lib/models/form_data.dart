import 'package:form_application/models/address.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/models/personal_details.dart';

class FormData {
  PersonalDetails? personalDetails;
  Address? address;
  ContactDetails? contactDetails;

  FormData({this.personalDetails, this.contactDetails, this.address});

  FormData copy() {
    return FormData(
      personalDetails: personalDetails!.copyWith(),
      address: address!.copyWith(),
      contactDetails: contactDetails!.copyWith(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:form_application/models/address.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';

class ViewScreen extends StatefulWidget {
  final int? id;
  const ViewScreen({super.key, required this.id});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  String? _name;
  String? _dateOfBirth;
  String? _gender;
  String? _addressLine;
  String? _pinCode;
  String? _city;
  String? _state;
  String? _country;
  String? _contactType;
  String? _contactValue;
  int? _isVerified;

  DatabaseHelper databaseHelper = DatabaseHelper();

  getData(int id) async {
    var personalDetails = await databaseHelper.getPersonalDetailsById(id);
    var address = await databaseHelper.getAddressBypersonalDetailsId(id);
    var contactDetails = await databaseHelper.getContactDetialsByPersonalDetailsId(id);
    PersonalDetails pd = PersonalDetails.fromMapObject(personalDetails.first);
    Address a = Address.fromMapObject(address.first);
    ContactDetails cd = ContactDetails.fromMapObject(contactDetails.first);
    print(cd.contactType);
    print(a.addressLine);
    print(pd.firstName);
    setState(() {
      _name = '${pd.firstName} ${pd.lastName}';
      _dateOfBirth = pd.dateOfBirth;
      _gender = pd.gender;
      _addressLine = a.addressLine;
      _pinCode = a.pinCode;
      _city = a.city;
      _state = a.state;
      _country = a.country;
      _contactType = cd.contactType;
      _contactValue = cd.contactValue;
      _isVerified = cd.isVerified;
    });
  }

  @override
  void initState() {
    getData(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('View Form', kClose, () {
        Navigator.pop(context);
      }),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        padding: kLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Personel Details -', style: textExtraLargeBlack,),
            SizedBox(height: kLargeGap,),
            Text('Name :  $_name', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('Date of Birth :  $_dateOfBirth', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('Gender :  $_gender', style: textLargeBlack,),
            SizedBox(height: kLargeGap,),
            SizedBox(height: kLargeGap,),
            Text('Address -', style: textExtraLargeBlack,),
            SizedBox(height: kLargeGap,),
            Text('Address Line :  $_addressLine', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('Pin Code :  $_pinCode', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('City :  $_city', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('State :  $_state', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('Country :  I$_country', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            SizedBox(height: kLargeGap,),
            SizedBox(height: kLargeGap,),
            Text('Contact Details -', style: textExtraLargeBlack,),
            SizedBox(height: kLargeGap,),
            Text('$_contactType :  $_contactValue', style: textLargeBlack,),
            SizedBox(height: kSmallGap,),
            Text('Verification Status :  ${_isVerified == 1 ? 'Done' : 'Pending'}', style: textLargeBlack,),
          ],
        ),
      ),
    );
  }
}

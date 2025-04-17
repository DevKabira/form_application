import 'package:flutter/material.dart';
import 'package:form_application/models/address.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';
import 'package:intl/intl.dart';

class ViewScreen extends StatefulWidget {
  final int? id;
  const ViewScreen({super.key, required this.id});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool _isEditable = false;
  int? addressId;
  int? contactId;
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _contactTypController = TextEditingController();
  final TextEditingController _contactValueController = TextEditingController();
  final TextEditingController _isVerifiedController = TextEditingController();
  PersonalDetails? _originalPersonalDetails;
  Address? _originalAddress;
  ContactDetails? _originalContactDetails;

  DatabaseHelper databaseHelper = DatabaseHelper();

  getData(int id) async {
    var personalDetails = await databaseHelper.getPersonalDetailsById(id);
    var address = await databaseHelper.getAddressBypersonalDetailsId(id);
    var contactDetails = await databaseHelper
        .getContactDetialsByPersonalDetailsId(id);
    PersonalDetails pd = PersonalDetails.fromMapObject(personalDetails.first);
    Address a = Address.fromMapObject(address.first);
    ContactDetails cd = ContactDetails.fromMapObject(contactDetails.first);

    setState(() {
      _originalPersonalDetails = pd;
      _originalAddress = a;
      _originalContactDetails = cd;

      addressId = a.id!;
      contactId = cd.id!;
      _fnameController.text = pd.firstName ?? '';
      _lnameController.text = pd.lastName ?? '';
      _dateOfBirthController.text = pd.dateOfBirth ?? '';
      _genderController.text = pd.gender ?? '';
      _addressLineController.text = a.addressLine ?? '';
      _pinCodeController.text = a.pinCode ?? '';
      _cityController.text = a.city ?? '';
      _stateController.text = a.state ?? '';
      _countryController.text = a.country ?? '';
      _contactTypController.text = cd.contactType ?? '';
      _contactValueController.text = cd.contactValue ?? '';
      _isVerifiedController.text = cd.isVerified.toString();
    });
  }

  @override
  void initState() {
    getData(widget.id!);
    super.initState();
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _addressLineController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _contactTypController.dispose();
    _contactValueController.dispose();
    _isVerifiedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kEditAppBar(
        'View',
        kClose,
        () {
          Navigator.pop(context, true);
        },
        _isEditable
            ? Icon(Icons.save, color: kWhite)
            : Icon(Icons.edit, color: kWhite),
        () async {
          if (_isEditable) {
            final updatedPersonalDetails = PersonalDetails.withId(
              id: widget.id,
              firstName: _fnameController.text,
              lastName: _lnameController.text,
              dateOfBirth: _dateOfBirthController.text,
              gender: _genderController.text,
            );
            final updatedAddress = Address.withId(
              id: addressId,
              personalDetailsId: widget.id,
              addressLine: _addressLineController.text,
              pinCode: _pinCodeController.text,
              city: _cityController.text,
              state: _stateController.text,
              country: _countryController.text,
            );
            final updateContactDetails = ContactDetails.withId(
              id: contactId,
              personalDetailsId: widget.id,
              contactType: _contactTypController.text,
              contactValue: _contactValueController.text,
              isVerified: _originalContactDetails!.isVerified,
            );
            if (_originalPersonalDetails != null &&
                _originalAddress != null &&
                _originalContactDetails != null) {
              if (_originalPersonalDetails != updatedPersonalDetails) {
                await databaseHelper.updatePersonalDetails(
                  updatedPersonalDetails,
                );
              }

              if (_originalAddress != updatedAddress) {
                await databaseHelper.updateAddress(updatedAddress);
              }

              if (_originalContactDetails != updateContactDetails) {
                await databaseHelper.updateContactDetails(updateContactDetails);
              }
            }
            Navigator.pop(context, true);
            setState(() {
              _isEditable = !_isEditable;
            });
          } else {
            setState(() {
              _isEditable = !_isEditable;
            });
          }
        },
      ),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        padding: kLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: kLargeGap),
            Text('Personal Details', style: textLargeBlack),
            SizedBox(height: kLargeGap),
            TextField(
              readOnly: !_isEditable,
              controller: _fnameController,
              decoration: kInputDecoration('First Name', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextField(
              readOnly: !_isEditable,
              controller: _lnameController,
              decoration: kInputDecoration('Last Name', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextField(
              readOnly: !_isEditable,
              controller: _dateOfBirthController,
              decoration: kInputDecoration(
                'Date of Birth',
                'Choose date',
              ).copyWith(
                suffixIcon: Icon(Icons.date_range),
                suffixIconColor: kGray,
              ),
              onTap:
                  _isEditable
                      ? () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.utc(1900),
                          lastDate: DateTime.utc(2100),
                          initialDate: DateTime.now(),
                        );
                        String formattedDate = DateFormat(
                          'yyyy-MM-dd',
                        ).format(date!);
                        setState(() {
                          _dateOfBirthController.text = formattedDate;
                        });
                      }
                      : () {},
            ),
            SizedBox(height: kLargeGap),
            DropdownButtonFormField<String>(
              iconEnabledColor: kGray,
              dropdownColor: kWhite,
              value:
                  ['Male', 'Female'].contains(_genderController.text)
                      ? _genderController.text
                      : null, // fallback if unexpected value
              hint: Text('Choose one', style: textMediumGray),
              decoration: kInputDecoration('Gender', 'Choose one'),
              items:
                  ['Male', 'Female']
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender, style: textMediumBlack),
                        ),
                      )
                      .toList(),
              onChanged:
                  _isEditable
                      ? (option) {
                        setState(() {
                          _genderController.text = option!;
                        });
                      }
                      : null, // disables interaction
              disabledHint: Text(
                _genderController.text.isNotEmpty
                    ? _genderController.text
                    : 'Not set',
                style: textMediumBlack,
              ),
            ),

            SizedBox(height: kLargeGap),
            SizedBox(height: kLargeGap),
            Text('Address', style: textLargeBlack),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _addressLineController,
              decoration: kInputDecoration('Address Line', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _pinCodeController,
              decoration: kInputDecoration('Pin Code', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _cityController,
              decoration: kInputDecoration('City', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _stateController,
              decoration: kInputDecoration('State', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _countryController,
              decoration: kInputDecoration('Country', 'Enter here'),
            ),
            SizedBox(height: kLargeGap),
            SizedBox(height: kLargeGap),
            Text('Contact Details', style: textLargeBlack),
            SizedBox(height: kLargeGap),
            TextFormField(
              readOnly: !_isEditable,
              controller: _contactValueController,
              decoration: kInputDecoration(
                _contactTypController.text,
                'Enter here',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

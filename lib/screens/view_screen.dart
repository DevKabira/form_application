import 'package:flutter/material.dart';
import 'package:form_application/models/address.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/models/form_data.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';
import 'package:form_application/utils/string_helper.dart';
import 'package:intl/intl.dart';

class ViewScreen extends StatefulWidget {
  final int? id;
  const ViewScreen({super.key, required this.id});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool _isEditable = false;
  FormData? formData;
  FormData? originalFormData;

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

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> getData(int id) async {
    final pdMap = await databaseHelper.getPersonalDetailsById(id);
    final aMap = await databaseHelper.getAddressBypersonalDetailsId(id);
    final cdMap = await databaseHelper.getContactDetialsByPersonalDetailsId(id);

    final PersonalDetails personalDetails = PersonalDetails.fromMapObject(
      pdMap.first,
    );
    final Address address = Address.fromMapObject(aMap.first);
    final ContactDetails contactDetails = ContactDetails.fromMapObject(
      cdMap.first,
    );

    setState(() {
      formData = FormData(
        personalDetails: personalDetails,
        address: address,
        contactDetails: contactDetails,
      );

      originalFormData = formData!.copy();

      _fnameController.text = StringHelper.capitalize(personalDetails.firstName);
      _lnameController.text = StringHelper.capitalize(personalDetails.lastName);
      _dateOfBirthController.text = StringHelper.capitalize(personalDetails.dateOfBirth);
      _genderController.text = StringHelper.capitalize(personalDetails.gender);
      _addressLineController.text = StringHelper.capitalize(address.addressLine);
      _pinCodeController.text = StringHelper.capitalize(address.pinCode);
      _cityController.text = StringHelper.capitalize(address.city);
      _stateController.text = StringHelper.capitalize(address.state);
      _countryController.text = StringHelper.capitalize(address.country);
      _contactTypController.text = StringHelper.capitalize(contactDetails.contactType);
      _contactValueController.text = StringHelper.capitalize(contactDetails.contactValue);
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
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final originalPD = originalFormData!.personalDetails!;
    final originalA = originalFormData!.address!;
    final originalCD = originalFormData!.contactDetails!;

    final updatedPD = originalPD.copyWith(
      firstName:
          _fnameController.text ,
      lastName:
          _lnameController.text,
      dateOfBirth:
          _dateOfBirthController.text ,
      gender:
          _genderController.text ,
    );

    final updatedA = originalA.copyWith(
      addressLine: _addressLineController.text,
      pinCode: _pinCodeController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
    );

    final updatedCD = originalCD.copyWith(
      contactValue: _contactValueController.text,
    );

    if (updatedPD != originalPD) {
      await databaseHelper.updatePersonalDetails(updatedPD);
    }
    if (updatedA != originalA) {
      await databaseHelper.updateAddress(updatedA);
    }
    if (updatedCD != originalCD) {
      await databaseHelper.updateContactDetails(updatedCD);
    }
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
            await _saveChanges();
            setState(() {
              _isEditable = !_isEditable;
            });
            if (mounted) {
              Navigator.pop(context, true);
            }
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

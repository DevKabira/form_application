import 'package:flutter/material.dart';
import 'package:form_application/models/address.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';

class FormTabTwo extends StatefulWidget {
  final TabController tabController;
  final int? personalDetailsId;

  const FormTabTwo({
    super.key,
    required this.tabController,
    required this.personalDetailsId,
  });

  @override
  State<FormTabTwo> createState() => _FormTabTwoState();
}

class _FormTabTwoState extends State<FormTabTwo> {
  // text fields controllers
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _addressLineController = TextEditingController();

  // database instance
  DatabaseHelper databaseHelper = DatabaseHelper();

  // what happens when the next button is pressed
  void onPress() async {
    String addressLine = _addressLineController.text.trim();
    String pinCode = _pinCodeController.text.trim();
    String city = _cityController.text.trim();
    String state = _stateController.text.trim();
    String country = _countryController.text.trim();

    Address address = Address(
      personalDetailsId: widget.personalDetailsId,
      addressLine: addressLine,
      pinCode: pinCode,
      city: city,
      state: state,
      country: country,
    );

    int result = await databaseHelper.insertAddress(address);
    result > 0 ? widget.tabController.animateTo(2) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        padding: kLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Address', style: textLargeBlack),
            SizedBox(height: kExtraLargeGap),
            Column(
              children: [
                TextFormField(
                  controller: _addressLineController,
                  decoration: kInputDecoration('Address Line', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _pinCodeController,
                  decoration: kInputDecoration('Pin Code', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _cityController,
                  decoration: kInputDecoration('City', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _stateController,
                  decoration: kInputDecoration('State', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _countryController,
                  decoration: kInputDecoration('Country', 'Enter here'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(kBlack),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          padding: WidgetStateProperty.all(kLargePadding),
        ),
        onPressed: onPress,
        child: Text('Next', style: textMediumWhite),
      ),
    );
  }
}

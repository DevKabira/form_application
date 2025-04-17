import 'package:flutter/material.dart';
import 'package:form_application/models/address.dart';
import 'package:form_application/models/form_data.dart';
import 'package:form_application/utils/constants.dart';

class FormTabTwo extends StatefulWidget {
  final TabController tabController;
  final FormData formData;

  const FormTabTwo({
    super.key,
    required this.tabController,
    required this.formData,
  });

  @override
  State<FormTabTwo> createState() => _FormTabTwoState();
}

class _FormTabTwoState extends State<FormTabTwo> {
  // text fields controllers
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _pinCodeController = TextEditingController();

  final TextEditingController _addressLineController = TextEditingController();

  // what happens when the next button is pressed
  void onPress() async {
    widget.formData.address = Address(
      addressLine: _addressLineController.text.trim(),
      pinCode: _pinCodeController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      country: _countryController.text.trim(),
    );
    widget.tabController.animateTo(2);
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
                  keyboardType: TextInputType.number,
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

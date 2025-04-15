import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';

class FormTabTwo extends StatefulWidget {
  const FormTabTwo({super.key});

  @override
  State<FormTabTwo> createState() => _FormTabTwoState();
}

class _FormTabTwoState extends State<FormTabTwo> {
  String? genderController;
  TextEditingController dateController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _streetController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  void onPress() {}

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
                  controller: _houseNumberController,
                  decoration: kInputDecoration('House number', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _streetController,
                  decoration: kInputDecoration('Street', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _pinCodeController,
                  decoration: kInputDecoration('Pin Code', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _cityController,
                  decoration: kInputDecoration('City', 'Auto Generate'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _stateController,
                  decoration: kInputDecoration('State', 'Auto Generate'),
                ),
                SizedBox(height: kLargeGap),
                TextFormField(
                  controller: _countryController,
                  decoration: kInputDecoration('Country', 'Auto Generate'),
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

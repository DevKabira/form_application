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

  @override
  void initState() {
    if (widget.formData.address != null) {
      _cityController.text = widget.formData.address!.city ?? '';
      _stateController.text = widget.formData.address!.state ?? '';
      _countryController.text = widget.formData.address!.country ?? '';
      _pinCodeController.text = widget.formData.address!.pinCode ?? '';
      _addressLineController.text = widget.formData.address!.addressLine ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.formData.address = Address(
      addressLine: _addressLineController.text,
      pinCode: _pinCodeController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
    );
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pinCodeController.dispose();
    _addressLineController.dispose();

    super.dispose();
  }

  // what happens when the next button is pressed
  void onPress() async {
    if (_addressLineController.text.trim().isEmpty ||
        _pinCodeController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _stateController.text.trim().isEmpty ||
        _countryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

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

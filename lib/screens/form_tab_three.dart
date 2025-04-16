import 'package:flutter/material.dart';
import 'package:form_application/models/contact_details.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class FormTabThree extends StatefulWidget {
  final int? personalDetailsId;

  const FormTabThree({super.key, required this.personalDetailsId});

  @override
  State<FormTabThree> createState() => _NewTabThreeState();
}

enum ContactType { phone, email }

class _NewTabThreeState extends State<FormTabThree> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  final otpController = OtpFieldController();
  final _contactValueController = TextEditingController();
  ContactType? _contactType;
  String? _verificationCode;
  int _isVerified = 0;
  bool canSendOtp = false;
  bool handleOtp = false;
  bool isLoading = false;

  void handleSendOtp() {
    setState(() {
      _isVerified = 1;
      handleOtp = true;
    });
  }

  void onPress() async {
    int personalDetailsId = widget.personalDetailsId!;
    int isVerified = _isVerified;
    String contactType = _contactType!.name;
    String contactValue = _contactValueController.text;

    ContactDetails contactDetails = ContactDetails(
      personalDetailsId: personalDetailsId,
      isVerified: isVerified,
      contactType: contactType,
      contactValue: contactValue,
    );

    int result = await databaseHelper.insertContactDetails(contactDetails);
    if (result > 0 && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        padding: kLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Details', style: textLargeBlack),
            SizedBox(height: kExtraLargeGap),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please verify one of the following',
                  style: textMediumBlack,
                ),
                SizedBox(height: kSmallGap),
                Column(
                  children: [
                    RadioListTile(
                      activeColor: kBlack,
                      title: Text('Phone', style: textMediumBlack),
                      value: ContactType.phone,
                      groupValue: _contactType,
                      onChanged: (ContactType? val) {
                        setState(() {
                          _contactType = val!;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: kBlack,
                      title: Text('Email', style: textMediumBlack),
                      value: ContactType.email,
                      groupValue: _contactType,
                      onChanged: (ContactType? val) {
                        setState(() {
                          _contactType = val!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: kSmallGap),
                _contactType != null
                    ? TextFormField(
                      controller: _contactValueController,
                      decoration: kInputDecoration(
                        '${_contactType!.name[0].toUpperCase()}${_contactType!.name.substring(1).toLowerCase()}',
                        'Enter here',
                      ).copyWith(
                        suffix:
                            canSendOtp
                                ? GestureDetector(
                                  onTap: handleSendOtp,
                                  child: Text(
                                    'Send OTP',
                                    style: textMediumGray.copyWith(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          value.length == 10
                              ? canSendOtp = true
                              : canSendOtp = false;
                          print(value);
                        });
                      },
                    )
                    : Container(),
                handleOtp
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: kLargeGap),
                        Text('Verify', style: textMediumBlack),
                        SizedBox(height: kSmallGap),
                        OTPTextField(
                          controller: otpController,
                          fieldStyle: FieldStyle.box,
                          isDense: true,
                          keyboardType: TextInputType.number,
                          outlineBorderRadius: 4,
                          style: textMediumBlack,
                          length: 6,
                          onCompleted: (pin) {
                            setState(() {
                              _verificationCode = pin;
                              handleOtp = false;
                              isLoading = true;
                              Future.delayed(Duration(seconds: 5), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            });
                          },
                          onChanged: (pin) {},
                        ),
                      ],
                    )
                    : Container(),
                SizedBox(height: kExtraLargeGap),
                Center(
                  child: Container(
                    child:
                        (_verificationCode != null)
                            ? (isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: kBlack,
                                  size: 24.0,
                                )
                                : Text(
                                  'Verification Successfull',
                                  style: textMediumBlack.copyWith(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                            : Container(),
                  ),
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
        child: Text('Submit', style: textMediumWhite),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class FormTabThree extends StatefulWidget {
  const FormTabThree({super.key});

  @override
  State<FormTabThree> createState() => _FormTabThreeState();
}

enum ContactOptions { phone, email }

class _FormTabThreeState extends State<FormTabThree> {
  final _controller = TextEditingController();
  final otpController = OtpFieldController();
  bool isLoading = false;
  bool otpField = false;
  String? code;

  ContactOptions? _contactOptions = ContactOptions.phone;

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
            Text('Contact Details', style: textLargeBlack),
            SizedBox(height: kExtraLargeGap),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Verify', style: textMediumBlack),
                Column(
                  children: [
                    ListTile(
                      title: Text('Phone'),
                      leading: Radio<ContactOptions>(
                        fillColor: WidgetStateProperty.all(kBlack),
                        value: ContactOptions.phone,
                        groupValue: _contactOptions,
                        onChanged: (ContactOptions? value) {
                          setState(() {
                            _contactOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Email'),
                      leading: Radio<ContactOptions>(
                        fillColor: WidgetStateProperty.all(kBlack),
                        value: ContactOptions.email,
                        groupValue: _contactOptions,
                        onChanged: (ContactOptions? value) {
                          setState(() {
                            _contactOptions = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kLargeGap),
                (_contactOptions == ContactOptions.phone)
                    ? TextFormField(
                      controller: _controller,
                      decoration: kInputDecoration(
                        'Phone',
                        'Enter here',
                      ).copyWith(
                        suffix: GestureDetector(
                          onTap: () {
                            if (_controller.text.length == 10) {
                              setState(() {
                                otpField = true;
                              });
                            }
                          },
                          child: Text(
                            'Send OTP',
                            style: textMediumGray.copyWith(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                    : TextField(
                      controller: _controller,
                      decoration: kInputDecoration(
                        'Email',
                        'Enter here',
                      ).copyWith(
                        suffix: GestureDetector(
                          onTap: () {
                            if (_controller.text.contains('@')) {
                              setState(() {
                                otpField = true;
                              });
                            }
                          },
                          child: Text(
                            'Send OTP',
                            style: textMediumGray.copyWith(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                SizedBox(height: kExtraLargeGap),
                (otpField)
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Verification Code', style: textMediumBlack),
                        SizedBox(height: kSmallGap),
                        OTPTextField(
                          controller: otpController,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 4,
                          style: textMediumBlack,
                          length: 6,
                          onCompleted: (pin) {
                            setState(() {
                              code = pin;
                              isLoading = true;
                            });
                            Future.delayed(Duration(seconds: 5), () {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          onChanged: (pin) {},
                        ),
                        SizedBox(height: kExtraLargeGap),
                        Center(
                          child:
                              (code != null)
                                  ? (isLoading
                                      ? LoadingAnimationWidget.staggeredDotsWave(
                                        color: kBlack,
                                        size: 48,
                                      )
                                      : Text(
                                        'Verification Successful',
                                        style: textLargeBlack.copyWith(
                                          color: Colors.green,
                                        ),
                                      ))
                                  : Container(),
                        ),
                      ],
                    )
                    : Container(),
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

import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/widgets/textfield_widget.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Form', kClose, () {
        Navigator.of(context).pop();
      }),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: kLargePadding,
          child: Column(
            children: [
              TextfieldWidget(title: 'First Name', hint: 'Enter here', type: 'text',),
              SizedBox(height: kLargeGap),
              TextfieldWidget(title: 'Last Name', hint: 'Enter here', type: 'text',),
              SizedBox(height: kLargeGap),
              TextfieldWidget(title: 'DOB', hint: 'Choose one', type: 'date',),
            ],
          ),
        ),
      ),
    );
  }
}

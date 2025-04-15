import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';
import 'package:intl/intl.dart';

class FormTabOne extends StatefulWidget {
  const FormTabOne({super.key});

  @override
  State<FormTabOne> createState() => _FormTabOneState();
}

class _FormTabOneState extends State<FormTabOne> {
  String? genderController;
  TextEditingController dateController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();

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
            Text('Personal Details', style: textLargeBlack),
            SizedBox(height: kExtraLargeGap),
            Column(
              children: [
                TextField(
                  controller: _fNameController,
                  decoration: kInputDecoration('First Name', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextField(
                  controller: _lNameController,
                  decoration: kInputDecoration('Last Name', 'Enter here'),
                ),
                SizedBox(height: kLargeGap),
                TextField(
                  controller: dateController,
                  decoration: kInputDecoration(
                    'Date of Birth',
                    'Choose date',
                  ).copyWith(
                    suffixIcon: Icon(Icons.date_range),
                    suffixIconColor: kGray,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.utc(1900),
                      lastDate: DateTime.utc(2100),
                      initialDate: DateTime.now(),
                    );
                    String formattedDate = DateFormat(
                      'dd-MM-yyyy',
                    ).format(date!);
                    setState(() {
                      dateController.text = formattedDate;
                    });
                                    },
                ),
                SizedBox(height: kLargeGap),
                DropdownButtonFormField(
                  iconEnabledColor: kGray,
                  dropdownColor: kWhite,
                  hint: Text('Choose one', style: textMediumGray),
                  decoration: kInputDecoration('Gender', 'Choose one'),
                  items:
                      ['Male', 'Female']
                          .map(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(option, style: textMediumBlack),
                            ),
                          )
                          .toList(),
                  onChanged: (option) {
                    setState(() {
                      genderController = option;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: kExtraLargeGap),
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

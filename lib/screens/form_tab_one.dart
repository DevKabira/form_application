  import 'package:flutter/material.dart';
  import 'package:form_application/models/personal_details.dart';
  import 'package:form_application/utils/constants.dart';
  import 'package:form_application/utils/database_helper.dart';
  import 'package:intl/intl.dart';

  class FormTabOne extends StatefulWidget {

    // to switch tabs when the button is pressed 
    final TabController tabController;
    final Function(int id) onSaved;
    const FormTabOne({super.key, required this.tabController, required this.onSaved});

    @override
    State<FormTabOne> createState() => _FormTabOneState();
  }

  class _FormTabOneState extends State<FormTabOne> {
    // id of the new entry
    int? _id;
    int get id => _id!;
    set id(int id) => _id = id;

    // text field controllers
    String? genderController;
    final _fNameController = TextEditingController();
    final _lNameController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    // database instance
    final DatabaseHelper databaseHelper = DatabaseHelper();

    // what happens when the next button is clicked
    void onPress() async {
      String firstName = _fNameController.text.trim();
      String lastName = _lNameController.text.trim();
      String dateOfBirth = dateController.text.trim();
      String gender = genderController!;

      // creates a PersonalDetails model
      PersonalDetails newEntry = PersonalDetails(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      // inserts the created model newEntry into the database
      int result = await databaseHelper.insertPersonalDetails(newEntry);
      if (result > 0) {
        id = result;
        print(result);
      }

      // Navigate to the next tab
      widget.onSaved(result);
      widget.tabController.animateTo(1);
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
                        'yyyy-MM-dd',
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

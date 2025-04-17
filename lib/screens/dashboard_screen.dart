import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/screens/form_screen.dart';
import 'package:form_application/screens/view_screen.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';
import 'package:form_application/utils/string_helper.dart';
import 'package:form_application/widgets/card_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PersonalDetails> personalDetailsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPersonalDetails();
  }

  void loadPersonalDetails() async {
    try {
      var personalDetailsData = await databaseHelper.getPersonalDetails();
      setState(() {
        personalDetailsList =
            personalDetailsData
                .map((data) => PersonalDetails.fromMapObject(data))
                .toList();
        isLoading = false;
      });
    } catch (e) {
      log('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Dashboard', kAdd, () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const FormScreen()))
            .then((_) {
              // Refresh the list when returning from form screen
              loadPersonalDetails();
            });
      }),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: kLargePadding,
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : personalDetailsList.isEmpty
                  ? const Center(child: Text('No records found'))
                  : ListView.separated(
                    itemCount: personalDetailsList.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: kLargeGap),
                    itemBuilder: (context, index) {
                      final person = personalDetailsList[index];
                      final fullName =
                          'Name - ${StringHelper.capitalize(person.firstName)} ${StringHelper.capitalize(person.lastName)}';
                      final dateOfBirth = 'DOB - ${person.dateOfBirth}';
                      final gender = 'Gender - ${person.gender}';
                      return Dismissible(
                        key: Key(
                          person.id.toString(),
                        ), // Use person.id as the key
                        onDismissed: (direction) {
                          // Ensure the item is removed from the list
                          databaseHelper.deletePersonalDetails(person.id!);
                          setState(() {
                            personalDetailsList.removeAt(index);
                          });

                          // Show the snackbar after the item has been removed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Form deleted successfully'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(16),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Delete', style: textExtraLargeWhite),
                              SizedBox(width: kLargeGap),
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewScreen(id: person.id),
                              ),
                            );
                            if (result == true) {
                              loadPersonalDetails();
                            }
                          },
                          child: CardWidget(
                            name: fullName.trim(),
                            dob: dateOfBirth.trim(),
                            gender: gender.trim(),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}

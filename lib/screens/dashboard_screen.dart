import 'package:flutter/material.dart';
import 'package:form_application/models/personal_details.dart';
import 'package:form_application/screens/form_screen.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/utils/database_helper.dart';
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
      print('Error loading personal details: $e');
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
                          '${person.firstName ?? ""} ${person.lastName ?? ""}';

                      return CardWidget(
                        title: fullName.trim(),
                        id: person.id ?? 0,
                      );
                    },
                  ),
        ),
      ),
    );
  }
}

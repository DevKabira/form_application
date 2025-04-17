import 'package:flutter/material.dart';
import 'package:form_application/models/form_data.dart';
import 'package:form_application/screens/form_tab_one.dart';
import 'package:form_application/screens/form_tab_three.dart';
import 'package:form_application/screens/form_tab_two.dart';
import 'package:form_application/utils/constants.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final FormData _formData = FormData(); //centralized form data

  late TabController _tabController;

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
          child: DefaultTabController(
            length: 3,
            child: Builder(
              builder: (context) {
                _tabController = DefaultTabController.of(context);
                return Scaffold(
                  backgroundColor: kWhite,
                  appBar: TabBar(
                    indicatorColor: kBlack,
                    labelColor: kBlack,
                    unselectedLabelStyle: textMediumGray,
                    tabs: [
                      Tab(child: Text('1')),
                      Tab(child: Text('2')),
                      Tab(child: Text('3')),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      FormTabOne(
                        tabController: _tabController,
                        formData: _formData,
                      ),
                      FormTabTwo(
                        tabController: _tabController,
                        formData: _formData,
                      ),
                      FormTabThree(formData: _formData),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

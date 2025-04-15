import 'package:flutter/material.dart';
import 'package:form_application/screens/form_tab_one.dart';
import 'package:form_application/screens/form_tab_three.dart';
import 'package:form_application/screens/form_tab_two.dart';
import 'package:form_application/utils/constants.dart';

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
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
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
              body: const TabBarView(
                children: [FormTabOne(), FormTabTwo(), FormTabThree()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



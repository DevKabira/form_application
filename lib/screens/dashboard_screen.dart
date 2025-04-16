import 'package:flutter/material.dart';
import 'package:form_application/screens/form_screen.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/widgets/card_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Dashboard', kAdd, () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const FormScreen()));
      }),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: kLargePadding,
          child: Column(
            children: [
              CardWidget(title: 'Kabeer', id: 10,),
              SizedBox(height: kLargeGap),
              CardWidget(title: 'Sohum', id: 2,),
            ],
          ),
        ),
      ),
    );
  }
}

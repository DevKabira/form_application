import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String dob;
  final String gender;
  const CardWidget({
    super.key,
    required this.name,
    required this.dob,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(color: Color(0xFFE5E5E5), blurRadius: 2, spreadRadius: 1),
        ],
        color: kWhite,
        border: Border(left: BorderSide(color: kBlack, width: 3)),
      ),
      child: Padding(
        padding: kLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: textLargeBlack),
            Text(dob, style: textLargeBlack),
            Text(gender, style: textLargeBlack),
          ],
        ),
      ),
    );
  }
}

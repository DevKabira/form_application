import 'package:flutter/material.dart';
import 'package:form_application/screens/view_screen.dart';
import 'package:form_application/utils/constants.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final int id;
  const CardWidget({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [BoxShadow(
          color: Color(0xFFE5E5E5),
          blurRadius: 2,
          spreadRadius: 1
        )],
        color: kWhite,
        border: Border(left: BorderSide(color: kBlack, width: 3))
      ),
      child: Padding(
        padding: kLargePadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textLargeBlack),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewScreen(id: id)));
            }, icon: Icon(Icons.file_open, color: kBlack,))
          ],
        ),
      ),
    );
  }
}

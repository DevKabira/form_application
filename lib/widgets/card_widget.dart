import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';
import 'package:form_application/widgets/icon_button_widget.dart';

class CardWidget extends StatelessWidget {
  final String title;
  const CardWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [BoxShadow(color: kGray, spreadRadius: 2, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: textLargeBlack),
          SizedBox(height: kLargeGap),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: IconButtonWidget(icon: kViewIcon, onTab: () {})),
              Expanded(child: IconButtonWidget(icon: kDelete, onTab: () {})),
              Expanded(child: IconButtonWidget(icon: kEdit, onTab: () {})),
            ],
          ),
        ],
      ),
    );
  }
}

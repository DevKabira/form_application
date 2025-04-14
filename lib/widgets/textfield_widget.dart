import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';

class TextfieldWidget extends StatelessWidget {
  final String title;
  final String hint;
  final String type;
  const TextfieldWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textMediumBlack),
        SizedBox(height: kSmallGap),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textMediumGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: kGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: kBlack),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:form_application/utils/constants.dart';


class IconButtonWidget extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTab;

  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        color: kBlack,
        padding: kLargePadding,
        child: icon,
      ),
    );
  }
}
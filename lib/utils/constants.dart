import 'package:flutter/material.dart';

// Font-family
const String kFontFamily = 'Poppins';

// Font-weights
const FontWeight kLightFontWeight = FontWeight.w300;
const FontWeight kRegularFontWeight = FontWeight.w400;
const FontWeight kMediumFontWeight = FontWeight.w500;

// Font-sizes
const double kExtraLargeFontSize = 20.0;
const double kLargeFontSize = 16.0;
const double kMediumFontSize = 14.0;
const double kSmallFontSize = 12.0;

// Colors
const Color kBlack = Color(0xFF171717);
const Color kGray = Color(0xFFC5C5C5);
const Color kWhite = Color(0xFFFFFFFF);

// Padding
const EdgeInsets kLargePadding = EdgeInsets.all(16.0);
const EdgeInsets kSmallPadding = EdgeInsets.all(12.0);

// Gaps
const double kExtraLargeGap = 24.0;
const double kLargeGap = 12.0;
const double kSmallGap = 8.0;

// Icons
const Icon kViewIcon = Icon(Icons.open_in_new, color: kWhite, size: 24);
const Icon kDelete = Icon(Icons.delete, color: kWhite, size: 24);
const Icon kEdit = Icon(Icons.edit_square, color: kWhite, size: 24);
const Icon kClose = Icon(Icons.close, color: kWhite, size: 24);
const Icon kAdd = Icon(Icons.add, color: kWhite, size: 24);

// TextSyle
TextStyle createTextStyle(Color color, double size, FontWeight weight) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}

// Custome TextStyles for direct use in the app
TextStyle textExtraLargeBlack = createTextStyle(
  kBlack,
  kExtraLargeFontSize,
  kRegularFontWeight,
);
TextStyle textLargeBlack = createTextStyle(
  kBlack,
  kLargeFontSize,
  kMediumFontWeight,
);
TextStyle textMediumBlack = createTextStyle(
  kBlack,
  kMediumFontSize,
  kRegularFontWeight,
);
TextStyle textSmallBlack = createTextStyle(
  kBlack,
  kSmallFontSize,
  kLightFontWeight,
);

TextStyle textExtraLargeWhite = createTextStyle(
  kWhite,
  kExtraLargeFontSize,
  kRegularFontWeight,
);
TextStyle textLargeWhite = createTextStyle(
  kWhite,
  kLargeFontSize,
  kMediumFontWeight,
);
TextStyle textMediumWhite = createTextStyle(
  kWhite,
  kMediumFontSize,
  kRegularFontWeight,
);
TextStyle textSmallWhite = createTextStyle(
  kWhite,
  kSmallFontSize,
  kLightFontWeight,
);

TextStyle textExtraLargeGray = createTextStyle(
  kGray,
  kExtraLargeFontSize,
  kRegularFontWeight,
);
TextStyle textLargeGray = createTextStyle(
  kGray,
  kLargeFontSize,
  kMediumFontWeight,
);
TextStyle textMediumGray = createTextStyle(
  kGray,
  kMediumFontSize,
  kRegularFontWeight,
);
TextStyle textSmallGray = createTextStyle(
  kGray,
  kSmallFontSize,
  kLightFontWeight,
);

// AppBar
AppBar kAppBar(String title, Icon icon, VoidCallback onTap) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kBlack,
    centerTitle: false,
    actionsPadding: EdgeInsets.only(right: 16),
    title: Text(title, style: textExtraLargeWhite),
    actions: [GestureDetector(onTap: onTap, child: icon)],
  );
}

// InputDecoration
InputDecoration kInputDecoration(String lable, String hint) {
  return InputDecoration(
    floatingLabelStyle: textMediumBlack,
    labelText: lable,
    labelStyle: textMediumGray,
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
  );
}

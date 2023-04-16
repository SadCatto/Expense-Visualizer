import 'package:flutter/material.dart';

import 'layout.dart';
Color primary = Colors.white;
class Styles{
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFeeedf2);
  static Color orangeColor = const Color(0xFFF37B67);
  static Color kakiColor = const Color(0xFFd2bdd6);
  static TextStyle textStyle = TextStyle(
      fontSize: AppLayout.getWidth(16),
      color: textColor,
      fontWeight: FontWeight.w500
  );
  static TextStyle headLineStyle = TextStyle(
      fontSize: AppLayout.getWidth(26),
      color: textColor,
      fontWeight: FontWeight.bold
  );
  static TextStyle headLineStyle2 = TextStyle(
      fontSize: AppLayout.getWidth(21),
      color: textColor,
      fontWeight: FontWeight.bold
  );
  static TextStyle headLineStyle3 = TextStyle(
      fontSize: AppLayout.getWidth(17),
      color: Colors.grey.shade500,
      fontWeight: FontWeight.w500
  );
  static TextStyle headLineStyle4 = TextStyle(
      fontSize: AppLayout.getWidth(14),
      color: Colors.grey.shade500,
      fontWeight: FontWeight.w500
  );
}

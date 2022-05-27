import 'package:flutter/material.dart';

class ColorService{
  // #Used for: background
  static const darkBlue =  Color(0xff010126);

  // #Used for: region
  static const lightBlue1 = Color(0xffcdc5ff);
  // #Used for: date, country, refresh_button
  static const lightBlue2 = Color(0xffa5a0ff);

  // #Used for: weather data
  static final gradientTopBody = const Color(0x00a5a6f6).withOpacity(0.1);
  static final gradientBottomBody = const Color(0xFFFFFFFF).withOpacity(0.05);
  static final gradientTopBorder = const Color(0x00a5a6f6).withOpacity(0.5);
  static final gradientBottomBorder = const Color((0xFFFFFFFF)).withOpacity(0.5);

  // #Used for: hourly data
  static final gradientHourlyBody = const Color(0xff0e0d2e).withOpacity(0.6);
  static final shadowTop = const Color(0xff179EFF).withOpacity(0.4);
  static final shadowBottom = const Color(0xff179EFF).withOpacity(0.1);
}
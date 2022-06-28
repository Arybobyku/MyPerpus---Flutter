import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';

class Constants{
  static const String userName = 'userName';
  static const String role = 'role';
}


final kRoundedContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(color: ColorPalette.generalPrimaryColor,width: 2),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 7,
      offset: Offset(0, 1), // changes position of shadow
    ),
  ],
);
import 'package:flutter/material.dart';

class FontFamily {
  static const poppins = 'poppins';
  static const inter = 'inter';
  static const nunito = 'nunito';
}

BoxShadow shadowSmall = BoxShadow(
  color: Colors.black.withOpacity(0.25),
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(1, 1),
);
BoxShadow shadowExtraSmall = BoxShadow(
  color: Colors.black.withOpacity(0.25),
  spreadRadius: 0.5,
  blurRadius: 0.5,
  offset: Offset(1, 1),
);

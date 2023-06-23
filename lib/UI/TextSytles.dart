import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

dynamic Styles({
  Color color=Colors.white,
  double size=20,
  bool bold=false
}){
  return GoogleFonts.lato(
    color: color,
    fontSize: size,
    fontWeight: bold?FontWeight.bold:FontWeight.normal
  );
}
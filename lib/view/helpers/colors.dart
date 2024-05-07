import 'package:flutter/material.dart';

class CustomColor {
  const CustomColor(
      {required this.shade50,
      required this.shade100,
      required this.shade200,
      required this.shade300,
      required this.shade400,
      required this.shade500,
      required this.shade600,
      required this.shade700,
      required this.shade800,
      required this.shade900});

  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;

    static CustomColor darkColor = const CustomColor(
    shade50: Color(0xFFE9E9E9),
    shade100: Color(0xFFBABABA),
    shade200: Color(0xFF999999),
    shade300: Color(0xFF6B6B6B),
    shade400: Color(0xFF4E4E4E),
    shade500: Color(0xFF222222),
    shade600: Color(0xFF1F1F1F),
    shade700: Color(0xFF181818),
    shade800: Color(0xFF131313),
    shade900: Color(0xFF0E0E0E),
  );
  
  static CustomColor appWhiteColor = const CustomColor(
    shade50: Color(0xFFFFFFFF),
    shade100: Color(0xFFFEFEFE),
    shade200: Color(0xFFFEFEFE),
    shade300: Color(0xFFFDFDFD),
    shade400: Color(0xFFFDFDFD),
    shade500: Color(0xFFFCFCFC),
    shade600: Color(0xFFE5E5E5),
    shade700: Color(0xFFB3B3B3),
    shade800: Color(0xFF8B8B8B),
    shade900: Color(0xFF6A6A6A),
  );

}
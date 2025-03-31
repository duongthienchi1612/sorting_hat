import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const mainColor = Color(0xFFFBE4C5);
  static const redBorder = Color(0xFF3B2C25);
  
  // Thêm màu sắc mới
  static const darkBrown = Color(0xFF6E4B3A);
  static const goldenYellow = Color(0xFFD4AF37);
  static const maroonRed = Color(0xFF740001);
  static const deepGreen = Color(0xFF1A472A);
  static const darkBlue = Color(0xFF0E1A40);
  static const brightYellow = Color(0xFFFFD700);
  static const warmBrown = Color(0xFF5D4037);
  
  // Màu sắc cho các nhà
  static const gryffindorPrimary = Color(0xFFAE0001);
  static const gryffindorSecondary = Color(0xFFEEBA30);
  
  static const ravenclawPrimary = Color(0xFF0E1A40);
  static const ravenclawSecondary = Color(0xFF946B2D);
  
  static const hufflepuffPrimary = Color(0xFFFFB81C);
  static const hufflepuffSecondary = Color(0xFF000000);
  
  static const slytherinPrimary = Color(0xFF1A472A);
  static const slytherinSecondary = Color(0xFFAAAAAA);

  // Gradients
  static const parchemntGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFBE4C5),
      Color(0xFFEDD9AB),
    ],
  );
}
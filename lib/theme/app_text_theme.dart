import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme textTheme = TextTheme(
    // Tiêu đề chính
    displayLarge: TextStyle(
      fontSize: 36,
      fontFamily: 'Caudex',
      color: AppColors.mainColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      shadows: [
        Shadow(
          blurRadius: 8,
          offset: Offset(2, 2),
          color: Colors.black.withOpacity(0.6),
        ),
      ],
    ),
    // Tiêu đề phụ
    displayMedium: TextStyle(
      fontSize: 28,
      fontFamily: 'Caudex',
      color: AppColors.mainColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3,
      shadows: [
        Shadow(
          blurRadius: 6,
          offset: Offset(1.5, 1.5),
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    ),
    // Văn bản chính
    bodyLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Caudex',
      color: AppColors.mainColor,
      letterSpacing: 0.2,
      shadows: [
        Shadow(
          blurRadius: 4,
          offset: Offset(1, 1),
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    ),
    // Văn bản phụ
    bodyMedium: TextStyle(
      fontSize: 18,
      fontFamily: 'Caudex',
      color: Colors.black87,
      letterSpacing: 0.1,
    ),
    // Chú thích
    bodySmall: TextStyle(
      fontSize: 16,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0.1,
      shadows: [
        Shadow(
          blurRadius: 3,
          offset: Offset(1, 1),
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    ),
    // Định nghĩa cho nút hoặc văn bản hành động
    labelLarge: TextStyle(
      fontSize: 20,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.bold,
      color: AppColors.redBorder,
      letterSpacing: 0.2,
      shadows: [
        Shadow(
          blurRadius: 2,
          offset: Offset(0.5, 0.5),
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    ),
  );
}

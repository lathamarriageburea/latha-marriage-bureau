import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle heroTitle = GoogleFonts.playfairDisplay(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.1,
  );

  static TextStyle heroSubtitle = GoogleFonts.poppins(
    fontSize: 20,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle sectionTitle = GoogleFonts.playfairDisplay(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle sectionSubtitle = GoogleFonts.poppins(
    fontSize: 17,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle cardDescription = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.textPrimary,
    height: 1.7,
  );
}
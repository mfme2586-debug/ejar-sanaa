import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette (Inspired by Sana'a Architecture)
  static const Color primaryColor = Color(0xFFA46960); // Brick Red - Yajour
  static const Color backgroundColor = Color(0xFFFAFAFA); // Gypsum White
  static const Color secondaryColor = Color(0xFF1385A7); // Qamariya Blue
  static const Color textColor = Color(0xFF2A1E1C); // Basalt Dark Brown
  static const Color successColor = Color(0xFF227A62); // Farm Green
  static const Color cardColor = Colors.white;
  static const Color borderColor = Color(0xFFE0E0E0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Colors
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        background: backgroundColor,
        error: Colors.red.shade700,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onBackground: textColor,
        onError: Colors.white,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: backgroundColor,
      
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Text Theme (Arabic)
      textTheme: GoogleFonts.cairoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: textColor),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textColor),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: primaryColor, width: 1.5),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 24,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

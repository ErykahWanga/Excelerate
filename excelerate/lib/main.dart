import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart'; // 

class AppColors {
  static const Color primary = Color(0xFFFFB300);
  static const Color secondary = Color(0xFFE65100);
  static const Color background = Color(0xFFFFF8E1); 
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF212121);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        onPrimary: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.text,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 4,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        foregroundColor: AppColors.text,
        centerTitle: true,
        titleTextStyle: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() {
  runApp(const ExcelerateApp());
}

class ExcelerateApp extends StatelessWidget {
  const ExcelerateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(), // Added this route
      },
    );
  }
}
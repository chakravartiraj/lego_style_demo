import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final legoTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212), // Deep Charcoal
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6C63FF), // Electric Indigo
    secondary: Color(0xFF03DAC6), // Neon Cyan
    surface: Color(0xFF1E1E1E), // Elevated Dark Card
  ),
  textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF121212),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF1E1E1E),
    elevation: 12,
    shadowColor: const Color(0xFF6C63FF).withValues(alpha: 0.2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    tileColor: const Color(0xFF1E1E1E),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  ),
);

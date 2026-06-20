import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Gradient
  static const Color primaryPurple = Color(0xFF6B4EFF);
  static const Color primaryPink = Color(0xFFFF6B9D);
  static const Color accentPink = Color(0xFFFF2D78);

  // Dark Background
  static const Color darkBg = Color(0xFF0A0A1A);
  static const Color darkBgSecondary = Color(0xFF1A1A2E);
  static const Color darkSurface = Color(0xFF16213E);
  static const Color darkCard = Color(0xFF1E2A45);

  // Glass
  static const Color glassWhite = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassHighlight = Color(0x0DFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF);
  static const Color textTertiary = Color(0x66FFFFFF);

  // Status
  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF60A5FA);

  // Oshi Default Colors
  static const List<Color> oshiColors = [
    Color(0xFFFF6B9D), // Pink
    Color(0xFF6B4EFF), // Purple
    Color(0xFF60A5FA), // Blue
    Color(0xFF4ADE80), // Green
    Color(0xFFFBBF24), // Yellow
    Color(0xFFEF4444), // Red
    Color(0xFFF97316), // Orange
    Color(0xFF8B5CF6), // Violet
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Hot Pink
    Color(0xFFA78BFA), // Lavender
    Color(0xFF34D399), // Emerald
  ];

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkBg, darkBgSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient oshiGradient(Color color) {
    return LinearGradient(
      colors: [color.withValues(alpha: 0.8), color.withValues(alpha: 0.3)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

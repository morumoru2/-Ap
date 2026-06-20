import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

/// ガラスモーフィズムのスタイル定義
class GlassTheme {
  GlassTheme._();

  /// 標準的なガラス効果の装飾
  static BoxDecoration get decoration => BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      );

  /// 強調されたガラス効果の装飾
  static BoxDecoration get decorationStrong => BoxDecoration(
        color: const Color(0x1FFFFFFF),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: const Color(0x33FFFFFF),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      );

  /// 推しカラー付きガラス装飾
  static BoxDecoration oshiDecoration(Color oshiColor) => BoxDecoration(
        color: oshiColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: oshiColor.withValues(alpha: 0.2),
          width: 1,
        ),
      );

  /// ブラーシグマ値
  static const double blurSigma = AppConstants.glassBlurSigma;

  /// ガラス効果のImageFilter
  static ImageFilter get blurFilter => ImageFilter.blur(
        sigmaX: blurSigma,
        sigmaY: blurSigma,
      );
}

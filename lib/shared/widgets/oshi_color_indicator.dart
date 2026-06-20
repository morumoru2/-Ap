import 'package:flutter/material.dart';

/// 推しカラーインジケータ
class OshiColorIndicator extends StatelessWidget {
  final Color color;
  final double size;
  final bool isSelected;

  const OshiColorIndicator({
    super.key,
    required this.color,
    this.size = 24,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: isSelected ? 2.5 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: isSelected ? 12 : 4,
            spreadRadius: isSelected ? 2 : 0,
          ),
        ],
      ),
    );
  }
}

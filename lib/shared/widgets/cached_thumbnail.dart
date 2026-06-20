import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CachedThumbnail extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final double borderRadius;
  final IconData fallbackIcon;

  const CachedThumbnail({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.fallbackIcon = Icons.video_library,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return _fallback();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: width,
          height: height,
          color: AppColors.darkBgSecondary,
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (_, __, ___) => _fallback(),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(fallbackIcon, color: Colors.white30, size: width * 0.3),
    );
  }
}

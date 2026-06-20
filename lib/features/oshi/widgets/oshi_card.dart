import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/widgets/glass_card.dart';
import '../oshi_provider.dart';

class OshiCard extends ConsumerWidget {
  final Oshi oshi;

  const OshiCard({super.key, required this.oshi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oshiColor = oshi.color != null 
        ? ColorUtils.fromHex(oshi.color!) 
        : AppColors.primaryPink;

    final birthday = oshi.birthday != null 
        ? AppDateUtils.tryParse(oshi.birthday) 
        : null;

    final daysLeft = birthday != null 
        ? AppDateUtils.daysUntilBirthday(birthday) 
        : null;

    return GlassCard(
      onTap: () => context.push('/oshi/${oshi.id}'),
      color: oshiColor.withValues(alpha: 0.1),
      borderColor: oshiColor.withValues(alpha: 0.3),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (oshi.imagePath != null && File(oshi.imagePath!).existsSync())
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.file(
                      File(oshi.imagePath!),
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.oshiGradient(oshiColor),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.white70,
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      ref.read(oshiOperationsProvider).toggleFavorite(oshi.id, !oshi.isFavorite);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        oshi.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: oshi.isFavorite ? AppColors.accentPink : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  oshi.name,
                  style: AppTextStyles.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (oshi.groupName != null && oshi.groupName!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    oshi.groupName!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: oshiColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: oshiColor.withValues(alpha: 0.6),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        daysLeft != null 
                            ? (daysLeft == 0 ? '本日誕生日！' : '誕生日まで $daysLeft日')
                            : '誕生日未設定',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: daysLeft == 0 ? AppColors.accentPink : AppColors.textTertiary,
                          fontWeight: daysLeft == 0 ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

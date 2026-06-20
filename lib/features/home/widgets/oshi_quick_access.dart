import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/color_utils.dart';
import '../home_provider.dart';

class OshiQuickAccess extends ConsumerWidget {
  const OshiQuickAccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteOshiProvider);

    return favoritesAsync.when(
      data: (oshis) {
        if (oshis.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'お気に入り',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: oshis.length,
                itemBuilder: (context, index) {
                  final oshi = oshis[index];
                  final oshiColor = oshi.color != null 
                      ? ColorUtils.fromHex(oshi.color!) 
                      : AppColors.primaryPink;

                  return GestureDetector(
                    onTap: () => context.push('/oshi/${oshi.id}'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: oshiColor, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: oshiColor.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: oshi.imagePath != null && File(oshi.imagePath!).existsSync()
                                  ? Image.file(
                                      File(oshi.imagePath!),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        gradient: AppColors.oshiGradient(oshiColor),
                                      ),
                                      child: const Icon(Icons.person, color: Colors.white70),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 70,
                            child: Text(
                              oshi.name,
                              style: const TextStyle(fontSize: 11, color: Colors.white70),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/icloud_service.dart';
import '../../core/services/icloud_sync_service.dart';
import '../../shared/widgets/glass_card.dart';
import 'settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '機能',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.book_outlined, color: Colors.white70),
                    title: const Text('推し日記'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/diary'),
                  ),
                  const Divider(color: AppColors.glassBorder, height: 1),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined, color: Colors.white70),
                    title: const Text('グッズ管理'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/goods'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '同期',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: FutureBuilder<bool>(
                future: ICloudService.isAvailable(),
                builder: (context, snapshot) {
                  final available = snapshot.data ?? false;
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          available ? Icons.cloud_done : Icons.cloud_off,
                          color: available ? Colors.greenAccent : Colors.white38,
                        ),
                        title: const Text('iCloud 同期'),
                        subtitle: Text(
                          available
                              ? 'データは iCloud に保存されます'
                              : 'iCloud にサインインしてください',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: TextButton(
                          onPressed: available
                              ? () async {
                                  await ICloudSyncService.pushOnBackground();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('iCloud に同期しました')),
                                    );
                                  }
                                }
                              : null,
                          child: const Text('今すぐ同期'),
                        ),
                      ),
                      const Divider(color: AppColors.glassBorder, height: 1),
                      const ListTile(
                        leading: Icon(Icons.widgets_outlined, color: Colors.white70),
                        title: Text('ホーム画面 Widget'),
                        subtitle: Text(
                          'ホーム画面長押し → ＋ → OshiMemo を追加',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '一般設定',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.dark_mode, color: Colors.white70),
                          SizedBox(width: 16),
                          Text('ダークモード (推奨)', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Switch(
                        value: settings.isDarkMode,
                        onChanged: (val) {
                          settingsNotifier.toggleTheme();
                        },
                        activeColor: AppColors.primaryPink,
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.glassBorder, height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.format_size, color: Colors.white70),
                          SizedBox(width: 16),
                          Text('文字サイズ倍率', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('小', style: TextStyle(fontSize: 12, color: Colors.white54)),
                          Expanded(
                            child: Slider(
                              value: settings.fontSizeFactor,
                              min: 0.8,
                              max: 1.4,
                              divisions: 3,
                              label: '${(settings.fontSizeFactor * 100).toInt()}%',
                              onChanged: (val) {
                                settingsNotifier.updateFontSize(val);
                              },
                              activeColor: AppColors.primaryPink,
                            ),
                          ),
                          const Text('大', style: TextStyle(fontSize: 12, color: Colors.white54)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'アプリ情報',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                children: [
                  _infoRow(context, 'アプリ名', AppConstants.appName),
                  const Divider(color: AppColors.glassBorder, height: 24),
                  _infoRow(context, 'バージョン', AppConstants.appVersion),
                  const Divider(color: AppColors.glassBorder, height: 24),
                  _infoRow(context, 'ライセンス', 'MIT License'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 15, color: Colors.white70)),
        Text(value, style: const TextStyle(fontSize: 15, color: Colors.white)),
      ],
    );
  }
}

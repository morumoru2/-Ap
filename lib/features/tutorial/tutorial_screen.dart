import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/app_prefs.dart';

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    _TutorialPage(
      icon: Icons.favorite,
      title: 'OshiMemo へようこそ',
      description: '推し活情報をシンプル・安全に、あなたのiPhone内だけで管理できます。',
    ),
    _TutorialPage(
      icon: Icons.person_add,
      title: '推しを登録',
      description: '推しの名前、誕生日、YouTubeチャンネルIDなどを登録しましょう。',
    ),
    _TutorialPage(
      icon: Icons.rss_feed,
      title: '新着動画をチェック',
      description: 'YouTube RSSから新着動画を自動取得。ライブ配信も検知します。',
    ),
    _TutorialPage(
      icon: Icons.calendar_month,
      title: '予定・日記・グッズ',
      description: 'カレンダー、推し活日記、グッズ管理で推し活を記録できます。',
    ),
  ];

  Future<void> _finish({bool registerOshi = false}) async {
    await AppPrefs.setTutorialCompleted(true);
    if (!mounted) return;
    if (registerOshi) {
      context.go('/oshi-edit');
    } else {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.darkGradient),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _finish(),
                  child: const Text('スキップ'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (_, i) {
                    final page = _pages[i];
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                            ),
                            child: Icon(page.icon, size: 48, color: Colors.white),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            page.title,
                            style: AppTextStyles.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == _page
                          ? AppColors.primaryPink
                          : Colors.white24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(24),
                child: _page < _pages.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('次へ'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () => _finish(registerOshi: true),
                            child: const Text('推しを登録する'),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () => _finish(),
                            child: const Text('あとで登録する'),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorialPage {
  final IconData icon;
  final String title;
  final String description;

  const _TutorialPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}

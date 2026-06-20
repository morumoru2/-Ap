import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/services/icloud_sync_service.dart';
import 'core/services/widget_update_service.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/settings_provider.dart';
import 'main.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _syncOnBackground();
    } else if (state == AppLifecycleState.resumed) {
      _syncOnResume();
    }
  }

  Future<void> _syncOnBackground() async {
    await ICloudSyncService.pushOnBackground();
    final db = ref.read(databaseProvider);
    await WidgetUpdateService.updateFromDatabase(db);
  }

  Future<void> _syncOnResume() async {
    final updated = await ICloudSyncService.pullOnLaunch();
    if (updated && mounted) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('iCloud からデータを同期しました'),
        ),
      );
    }
    final db = ref.read(databaseProvider);
    await WidgetUpdateService.updateFromDatabase(db);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: 'OshiMemo',
      debugShowCheckedModeBanner: false,
      theme: settings.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(settings.fontSizeFactor),
          ),
          child: child!,
        );
      },
    );
  }
}

class AppShell extends StatefulWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final location = router.routerDelegate.currentConfiguration.uri.toString();

    if (location == '/') {
      _currentIndex = 0;
    } else if (location.startsWith('/oshi')) {
      _currentIndex = 1;
    } else if (location.startsWith('/feed')) {
      _currentIndex = 2;
    } else if (location.startsWith('/calendar')) {
      _currentIndex = 3;
    } else if (location.startsWith('/settings')) {
      _currentIndex = 4;
    } else {
      // Fallback or sub-routes that shouldn't change the tab index
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              router.go('/');
              break;
            case 1:
              router.go('/oshi');
              break;
            case 2:
              router.go('/feed');
              break;
            case 3:
              router.go('/calendar');
              break;
            case 4:
              router.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: '推しリスト',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            activeIcon: Icon(Icons.rss_feed),
            label: 'フィード',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: '予定',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

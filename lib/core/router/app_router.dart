import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/oshi/oshi_list_screen.dart';
import '../../features/oshi/oshi_detail_screen.dart';
import '../../features/oshi/oshi_edit_screen.dart';
import '../../features/rss/rss_feed_screen.dart';
import '../../features/calendar/calendar_screen.dart';
import '../../features/calendar/schedule_edit_screen.dart';
import '../../features/diary/diary_list_screen.dart';
import '../../features/diary/diary_edit_screen.dart';
import '../../features/goods/goods_list_screen.dart';
import '../../features/goods/goods_edit_screen.dart';
import '../../features/tutorial/tutorial_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../app.dart';
import '../../core/theme/page_transitions.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/tutorial',
        builder: (context, state) => const TutorialScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/oshi',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const OshiListScreen(),
            ),
          ),
          GoRoute(
            path: '/feed',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const RssFeedScreen(),
            ),
          ),
          GoRoute(
            path: '/calendar',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const CalendarScreen(),
            ),
          ),
          GoRoute(
            path: '/diary',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const DiaryListScreen(),
            ),
          ),
          GoRoute(
            path: '/goods',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const GoodsListScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/oshi/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          if (id == null) {
            return _buildPage(
              state: state,
              child: const HomeScreen(), // fallback
            );
          }
          return _buildPage(
            state: state,
            child: OshiDetailScreen(oshiId: id),
          );
        },
      ),
      GoRoute(
        path: '/oshi-edit',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final oshiId = state.extra as int?;
          return _buildPage(
            state: state,
            child: OshiEditScreen(oshiId: oshiId),
          );
        },
      ),
      GoRoute(
        path: '/schedule-edit',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final scheduleId = state.extra as int?;
          return _buildPage(
            state: state,
            child: ScheduleEditScreen(scheduleId: scheduleId),
          );
        },
      ),
      GoRoute(
        path: '/diary-edit',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra;
          int? diaryId;
          int? oshiId;
          if (extra is int) {
            diaryId = extra;
          } else if (extra is Map) {
            diaryId = extra['diaryId'] as int?;
            oshiId = extra['oshiId'] as int?;
          }
          return _buildPage(
            state: state,
            child: DiaryEditScreen(diaryId: diaryId, oshiId: oshiId),
          );
        },
      ),
      GoRoute(
        path: '/goods-edit',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra;
          int? goodsId;
          int? oshiId;
          if (extra is int) {
            goodsId = extra;
          } else if (extra is Map) {
            goodsId = extra['goodsId'] as int?;
            oshiId = extra['oshiId'] as int?;
          }
          return _buildPage(
            state: state,
            child: GoodsEditScreen(goodsId: goodsId, oshiId: oshiId),
          );
        },
      ),
    ],
  );

  static CustomTransitionPage _buildPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return AppPageTransitions.build(state: state, child: child);
  }
}

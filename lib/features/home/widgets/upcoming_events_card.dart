import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../oshi/oshi_provider.dart';
import '../../calendar/calendar_provider.dart';

class UpcomingEventsCard extends ConsumerWidget {
  const UpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oshiListAsync = ref.watch(oshiListProvider);
    final schedulesAsync = ref.watch(schedulesStreamProvider);

    return oshiListAsync.when(
      data: (oshis) => schedulesAsync.when(
        data: (schedules) {
          final events = <_UpcomingEvent>[];

          for (final o in oshis) {
            final birthday = AppDateUtils.tryParse(o.birthday);
            if (birthday == null) continue;
            final daysLeft = AppDateUtils.daysUntilBirthday(birthday);
            if (daysLeft <= 30) {
              events.add(_UpcomingEvent(
                title: '${o.name} の誕生日',
                subtitle: AppDateUtils.formatMonthDay(birthday),
                daysLeft: daysLeft,
                oshi: o,
                scheduleId: null,
              ));
            }
          }

          final now = DateTime.now();
          for (final s in schedules) {
            final daysLeft = s.eventDate.difference(now).inDays;
            if (daysLeft >= 0 && daysLeft <= 30) {
              final oshi = oshis.where((o) => o.id == s.oshiId).firstOrNull;
              if (oshi != null) {
                events.add(_UpcomingEvent(
                  title: s.title,
                  subtitle: AppDateUtils.formatDateTime(s.eventDate),
                  daysLeft: daysLeft,
                  oshi: oshi,
                  scheduleId: s.id,
                ));
              }
            }
          }

          events.sort((a, b) => a.daysLeft.compareTo(b.daysLeft));

          if (events.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'ちかいイベント',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final oshiColor = event.oshi.color != null
                      ? ColorUtils.fromHex(event.oshi.color!)
                      : AppColors.primaryPink;

                  return GlassCard(
                    onTap: () {
                      if (event.scheduleId != null) {
                        context.push('/schedule-edit', extra: event.scheduleId);
                      } else {
                        context.push('/oshi/${event.oshi.id}');
                      }
                    },
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    borderColor: oshiColor.withValues(alpha: 0.2),
                    child: Row(
                      children: [
                        Icon(
                          event.scheduleId != null
                              ? Icons.event
                              : Icons.cake,
                          color: oshiColor,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: oshiColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event.daysLeft == 0
                                ? '本日！'
                                : 'あと ${event.daysLeft}日',
                            style: TextStyle(
                              color: event.daysLeft == 0
                                  ? AppColors.accentPink
                                  : oshiColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _UpcomingEvent {
  final String title;
  final String subtitle;
  final int daysLeft;
  final Oshi oshi;
  final int? scheduleId;

  _UpcomingEvent({
    required this.title,
    required this.subtitle,
    required this.daysLeft,
    required this.oshi,
    required this.scheduleId,
  });
}

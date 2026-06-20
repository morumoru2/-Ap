import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/schedule_types.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/date_utils.dart';
import '../../database/app_database.dart';
import '../../shared/widgets/animated_fab.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/glass_card.dart';
import '../oshi/oshi_provider.dart';
import 'calendar_provider.dart';

class CalendarEvent {
  final String title;
  final DateTime date;
  final Color color;
  final String type;
  final int? scheduleId;
  final int? oshiId;

  CalendarEvent({
    required this.title,
    required this.date,
    required this.color,
    required this.type,
    this.scheduleId,
    this.oshiId,
  });
}

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<CalendarEvent> _buildEvents(
    List<Oshi> oshis,
    List<Schedule> schedules,
  ) {
    final events = <CalendarEvent>[];

    for (final oshi in oshis) {
      final birthday = AppDateUtils.tryParse(oshi.birthday);
      if (birthday == null) continue;
      final color = oshi.color != null
          ? ColorUtils.fromHex(oshi.color!)
          : AppColors.primaryPink;
      events.add(CalendarEvent(
        title: '${oshi.name} の誕生日',
        date: DateTime(_focusedDay.year, birthday.month, birthday.day),
        color: color,
        type: ScheduleTypes.birthday,
        oshiId: oshi.id,
      ));
    }

    for (final schedule in schedules) {
      final oshi = oshis.where((o) => o.id == schedule.oshiId).firstOrNull;
      final color = oshi?.color != null
          ? ColorUtils.fromHex(oshi!.color!)
          : AppColors.primaryPurple;
      events.add(CalendarEvent(
        title: schedule.title,
        date: schedule.eventDate,
        color: color,
        type: schedule.eventType,
        scheduleId: schedule.id,
        oshiId: schedule.oshiId,
      ));
    }

    return events;
  }

  List<CalendarEvent> _eventsForDay(
    DateTime day,
    List<CalendarEvent> all,
  ) {
    return all.where((e) {
      return e.date.year == day.year &&
          e.date.month == day.month &&
          e.date.day == day.day;
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    final oshiListAsync = ref.watch(oshiListProvider);
    final schedulesAsync = ref.watch(schedulesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
        actions: [
          IconButton(
            icon: Icon(
              _format == CalendarFormat.month
                  ? Icons.view_day
                  : Icons.calendar_view_month,
            ),
            onPressed: () {
              setState(() {
                _format = _format == CalendarFormat.month
                    ? CalendarFormat.week
                    : CalendarFormat.month;
              });
            },
          ),
        ],
      ),
      body: oshiListAsync.when(
        data: (oshis) => schedulesAsync.when(
          data: (schedules) {
            final allEvents = _buildEvents(oshis, schedules);
            final selectedEvents = _eventsForDay(_selectedDay, allEvents);

            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _format,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) => _eventsForDay(day, allEvents),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  locale: 'ja_JP',
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppColors.primaryPurple.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primaryPink,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: AppColors.accentPink,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      _selectedDay = selected;
                      _focusedDay = focused;
                    });
                  },
                  onPageChanged: (focused) {
                    _focusedDay = focused;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        AppDateUtils.formatDate(_selectedDay),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${selectedEvents.length}件',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: selectedEvents.isEmpty
                      ? const EmptyState(
                          icon: Icons.event_busy,
                          title: '予定がありません',
                          subtitle: '右下の＋ボタンからイベントを追加できます',
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            final event = selectedEvents[index];
                            return GlassCard(
                              margin: const EdgeInsets.only(bottom: 10),
                              borderColor: event.color.withValues(alpha: 0.3),
                              onTap: event.scheduleId != null
                                  ? () => context.push(
                                        '/schedule-edit',
                                        extra: event.scheduleId,
                                      )
                                  : event.oshiId != null
                                      ? () => context.push('/oshi/${event.oshiId}')
                                      : null,
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: event.color,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          ScheduleTypes.label(event.type),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: event.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (event.scheduleId != null)
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          color: Colors.redAccent, size: 20),
                                      onPressed: () async {
                                        await ref
                                            .read(scheduleOperationsProvider)
                                            .deleteSchedule(event.scheduleId!);
                                      },
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('エラー: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
      ),
      floatingActionButton: AnimatedFab(
        onPressed: () => context.push('/schedule-edit'),
        icon: Icons.add,
        tooltip: '予定を追加',
      ),
    );
  }
}

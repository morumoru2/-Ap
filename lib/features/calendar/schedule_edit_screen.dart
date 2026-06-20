import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/constants/app_colors.dart';
import '../../core/constants/schedule_types.dart';
import '../../core/utils/date_utils.dart';
import '../../database/app_database.dart';
import '../../main.dart';
import '../oshi/oshi_provider.dart';
import 'calendar_provider.dart';

class ScheduleEditScreen extends ConsumerStatefulWidget {
  final int? scheduleId;

  const ScheduleEditScreen({super.key, this.scheduleId});

  @override
  ConsumerState<ScheduleEditScreen> createState() =>
      _ScheduleEditScreenState();
}

class _ScheduleEditScreenState extends ConsumerState<ScheduleEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();

  int? _selectedOshiId;
  DateTime _eventDate = DateTime.now();
  TimeOfDay _eventTime = TimeOfDay.now();
  String _eventType = ScheduleTypes.event;
  bool _notificationEnabled = true;
  bool _isLoading = false;

  bool get _isEditMode => widget.scheduleId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final schedule = await db.getScheduleById(widget.scheduleId!);
    if (schedule != null) {
      _titleController.text = schedule.title;
      _memoController.text = schedule.memo ?? '';
      _selectedOshiId = schedule.oshiId;
      _eventDate = schedule.eventDate;
      _eventTime = TimeOfDay.fromDateTime(schedule.eventDate);
      _eventType = schedule.eventType;
      _notificationEnabled = schedule.notificationEnabled;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _eventDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _eventTime,
    );
    if (picked != null) setState(() => _eventTime = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedOshiId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('推しを選択してください')),
      );
      return;
    }

    final eventDateTime = DateTime(
      _eventDate.year,
      _eventDate.month,
      _eventDate.day,
      _eventTime.hour,
      _eventTime.minute,
    );

    final companion = SchedulesCompanion(
      oshiId: drift.Value(_selectedOshiId!),
      title: drift.Value(_titleController.text.trim()),
      eventDate: drift.Value(eventDateTime),
      eventType: drift.Value(_eventType),
      notificationEnabled: drift.Value(_notificationEnabled),
      memo: drift.Value(
        _memoController.text.trim().isEmpty ? null : _memoController.text.trim(),
      ),
    );

    final ops = ref.read(scheduleOperationsProvider);
    if (_isEditMode) {
      await ops.updateSchedule(companion.copyWith(
        id: drift.Value(widget.scheduleId!),
      ));
    } else {
      await ops.addSchedule(companion);
    }

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final oshiListAsync = ref.watch(oshiListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '予定を編集' : '予定を追加'),
        actions: [
          IconButton(onPressed: _save, icon: const Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'イベント名 (必須)'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '入力してください' : null,
              ),
              const SizedBox(height: 16),
              oshiListAsync.when(
                data: (oshis) {
                  if (oshis.isEmpty) {
                    return const Text('先に推しを登録してください');
                  }
                  _selectedOshiId ??= oshis.first.id;
                  return DropdownButtonFormField<int>(
                    value: _selectedOshiId,
                    decoration: const InputDecoration(labelText: '推し'),
                    items: oshis
                        .map((o) => DropdownMenuItem(
                              value: o.id,
                              child: Text(o.name),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedOshiId = v),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _eventType,
                decoration: const InputDecoration(labelText: '種類'),
                items: ScheduleTypes.labels.entries
                    .where((e) => e.key != ScheduleTypes.birthday)
                    .map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _eventType = v);
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                tileColor: AppColors.glassWhite,
                title: const Text('日付'),
                subtitle: Text(AppDateUtils.formatDate(_eventDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 8),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                tileColor: AppColors.glassWhite,
                title: const Text('時刻'),
                subtitle: Text(_eventTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('通知を有効にする'),
                subtitle: const Text('1時間前に通知します'),
                value: _notificationEnabled,
                onChanged: (v) => setState(() => _notificationEnabled = v),
                activeColor: AppColors.primaryPink,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _memoController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'メモ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

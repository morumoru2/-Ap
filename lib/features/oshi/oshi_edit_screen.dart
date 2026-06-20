import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/services/notification_scheduler.dart';
import '../../../main.dart';
import 'oshi_provider.dart';
import 'widgets/color_picker.dart';

class OshiEditScreen extends ConsumerStatefulWidget {
  final int? oshiId;

  const OshiEditScreen({super.key, this.oshiId});

  @override
  ConsumerState<OshiEditScreen> createState() => _OshiEditScreenState();
}

class _OshiEditScreenState extends ConsumerState<OshiEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _groupController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _memoController = TextEditingController();

  DateTime? _selectedBirthday;
  Color _selectedColor = AppColors.primaryPink;
  String? _imagePath;
  bool _isEditMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.oshiId != null;
    if (_isEditMode) {
      _loadOshiData();
    }
  }

  Future<void> _loadOshiData() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final oshi = await db.getOshiById(widget.oshiId!);
    if (oshi != null) {
      _nameController.text = oshi.name;
      _groupController.text = oshi.groupName ?? '';
      _youtubeController.text = oshi.youtubeChannelId ?? '';
      _memoController.text = oshi.memo ?? '';
      _selectedBirthday = AppDateUtils.tryParse(oshi.birthday);
      if (oshi.color != null) {
        _selectedColor = ColorUtils.fromHex(oshi.color!);
      }
      _imagePath = oshi.imagePath;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    _youtubeController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectBirthday() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedBirthday = pickedDate;
      });
    }
  }

  Future<void> _saveOshi() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final group = _groupController.text.trim();
    final youtubeId = _youtubeController.text.trim();
    final memo = _memoController.text.trim();
    final birthdayStr = _selectedBirthday != null 
        ? _selectedBirthday!.toIso8601String() 
        : null;
    final colorHex = ColorUtils.toHex(_selectedColor);

    final companion = OshisCompanion(
      name: drift.Value(name),
      groupName: drift.Value(group.isNotEmpty ? group : null),
      youtubeChannelId: drift.Value(youtubeId.isNotEmpty ? youtubeId : null),
      memo: drift.Value(memo.isNotEmpty ? memo : null),
      birthday: drift.Value(birthdayStr),
      color: drift.Value(colorHex),
      imagePath: drift.Value(_imagePath),
      updatedAt: drift.Value(DateTime.now()),
    );

    final ops = ref.read(oshiOperationsProvider);
    if (_isEditMode) {
      final updatedCompanion = companion.copyWith(
        id: drift.Value(widget.oshiId!),
      );
      await ops.updateOshi(updatedCompanion);
    } else {
      await ops.addOshi(companion.copyWith(
        createdAt: drift.Value(DateTime.now()),
      ));
    }

    await NotificationScheduler.syncAll(ref.read(databaseProvider));

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '推しを編集' : '推しを登録'),
        actions: [
          IconButton(
            onPressed: _saveOshi,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.glassWhite,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.glassBorder, width: 2),
                      image: _imagePath != null
                          ? DecorationImage(
                              image: FileImage(File(_imagePath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imagePath == null
                        ? const Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.white60)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '推しの名前 (必須)',
                  hintText: '例: 山田 花子',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return '名前を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _groupController,
                decoration: const InputDecoration(
                  labelText: 'グループ / 所属',
                  hintText: '例: アイドルグループA',
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                tileColor: AppColors.glassWhite,
                title: const Text('誕生日', style: TextStyle(color: Colors.white70, fontSize: 14)),
                subtitle: Text(
                  _selectedBirthday != null 
                      ? AppDateUtils.formatDate(_selectedBirthday!) 
                      : '未設定',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.calendar_today, color: Colors.white60),
                onTap: _selectBirthday,
              ),
              const SizedBox(height: 16),
              OshiColorPicker(
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _youtubeController,
                decoration: const InputDecoration(
                  labelText: 'YouTube チャンネル ID',
                  hintText: '例: UCxxxxxxxxxxxx',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _memoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  hintText: '推しのプロフィール、好きなところなど...',
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../core/constants/app_colors.dart';
import '../../database/app_database.dart';
import '../../main.dart';
import '../oshi/oshi_provider.dart';
import 'diary_provider.dart';

class DiaryEditScreen extends ConsumerStatefulWidget {
  final int? diaryId;
  final int? oshiId;

  const DiaryEditScreen({super.key, this.diaryId, this.oshiId});

  @override
  ConsumerState<DiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends ConsumerState<DiaryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();

  int? _selectedOshiId;
  String? _imagePath;
  bool _isLoading = false;

  bool get _isEditMode => widget.diaryId != null;

  @override
  void initState() {
    super.initState();
    _selectedOshiId = widget.oshiId;
    if (_isEditMode) _loadEntry();
  }

  Future<void> _loadEntry() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final entry = await db.getDiaryEntryById(widget.diaryId!);
    if (entry != null) {
      _contentController.text = entry.content;
      _tagsController.text = entry.tags ?? '';
      _selectedOshiId = entry.oshiId;
      _imagePath = entry.imagePath;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imagePath = picked.path);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedOshiId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('推しを選択してください')),
      );
      return;
    }

    String? finalImagePath = _imagePath;
    if (_imagePath != null && !_imagePath!.contains('app_flutter/diaries')) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final diariesDir = Directory(p.join(appDir.path, 'diaries'));
        if (!await diariesDir.exists()) {
          await diariesDir.create(recursive: true);
        }
        final fileName =
            '${DateTime.now().microsecondsSinceEpoch}${p.extension(_imagePath!)}';
        final newPath = p.join(diariesDir.path, fileName);
        final imageFile = File(_imagePath!);
        if (await imageFile.exists()) {
          await imageFile.copy(newPath);
          finalImagePath = newPath;
        }
      } catch (e) {
        debugPrint('Failed to save image: $e');
      }
    }

    final now = DateTime.now();
    final companion = DiaryEntriesCompanion(
      oshiId: drift.Value(_selectedOshiId!),
      content: drift.Value(_contentController.text.trim()),
      tags: drift.Value(
        _tagsController.text.trim().isEmpty
            ? null
            : _tagsController.text.trim(),
      ),
      imagePath: drift.Value(finalImagePath),
      updatedAt: drift.Value(now),
    );

    final ops = ref.read(diaryOperationsProvider);
    if (_isEditMode) {
      await ops.updateEntry(companion.copyWith(
        id: drift.Value(widget.diaryId!),
      ));
    } else {
      await ops.addEntry(companion.copyWith(
        createdAt: drift.Value(now),
      ));
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    if (!_isEditMode) return;
    await ref.read(diaryOperationsProvider).deleteEntry(widget.diaryId!);
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
        title: Text(_isEditMode ? '日記を編集' : '日記を書く'),
        actions: [
          if (_isEditMode)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: _delete,
            ),
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
              TextFormField(
                controller: _contentController,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: '今日の推し活',
                  hintText: 'ライブ感想、ガチャ記録など...',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '内容を入力してください' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'タグ（カンマ区切り）',
                  hintText: '例: ライブ, ガチャ',
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.glassBorder),
                    image: _imagePath != null
                        ? DecorationImage(
                            image: FileImage(File(_imagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate, size: 40),
                            SizedBox(height: 8),
                            Text('写真を添付'),
                          ],
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

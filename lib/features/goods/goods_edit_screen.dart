import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../core/constants/app_colors.dart';
import '../../core/constants/goods_status.dart';
import '../../database/app_database.dart';
import '../../main.dart';
import '../oshi/oshi_provider.dart';
import 'goods_provider.dart';

class GoodsEditScreen extends ConsumerStatefulWidget {
  final int? goodsId;
  final int? oshiId;

  const GoodsEditScreen({super.key, this.goodsId, this.oshiId});

  @override
  ConsumerState<GoodsEditScreen> createState() => _GoodsEditScreenState();
}

class _GoodsEditScreenState extends ConsumerState<GoodsEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _memoController = TextEditingController();

  int? _selectedOshiId;
  String _status = GoodsStatus.want;
  String? _imagePath;
  bool _isLoading = false;

  bool get _isEditMode => widget.goodsId != null;

  @override
  void initState() {
    super.initState();
    _selectedOshiId = widget.oshiId;
    if (_isEditMode) _loadGood();
  }

  Future<void> _loadGood() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final good = await db.getGoodById(widget.goodsId!);
    if (good != null) {
      _nameController.text = good.name;
      _priceController.text = good.price?.toString() ?? '';
      _memoController.text = good.memo ?? '';
      _selectedOshiId = good.oshiId;
      _status = good.status;
      _imagePath = good.imagePath;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _memoController.dispose();
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

    final priceText = _priceController.text.trim();
    final price = priceText.isEmpty ? null : int.tryParse(priceText);

    String? finalImagePath = _imagePath;
    if (_imagePath != null && !_imagePath!.contains('app_flutter/goods')) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final goodsDir = Directory(p.join(appDir.path, 'goods'));
        if (!await goodsDir.exists()) {
          await goodsDir.create(recursive: true);
        }
        final fileName =
            '${DateTime.now().microsecondsSinceEpoch}${p.extension(_imagePath!)}';
        final newPath = p.join(goodsDir.path, fileName);
        final imageFile = File(_imagePath!);
        if (await imageFile.exists()) {
          await imageFile.copy(newPath);
          finalImagePath = newPath;
        }
      } catch (e) {
        debugPrint('Failed to save goods image: $e');
      }
    }

    final now = DateTime.now();
    final companion = GoodsCompanion(
      oshiId: drift.Value(_selectedOshiId!),
      name: drift.Value(_nameController.text.trim()),
      price: drift.Value(price),
      status: drift.Value(_status),
      memo: drift.Value(
        _memoController.text.trim().isEmpty
            ? null
            : _memoController.text.trim(),
      ),
      imagePath: drift.Value(finalImagePath),
      updatedAt: drift.Value(now),
    );

    final ops = ref.read(goodsOperationsProvider);
    if (_isEditMode) {
      await ops.updateGood(companion.copyWith(
        id: drift.Value(widget.goodsId!),
      ));
    } else {
      await ops.addGood(companion.copyWith(
        createdAt: drift.Value(now),
      ));
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    if (!_isEditMode) return;
    await ref.read(goodsOperationsProvider).deleteGood(widget.goodsId!);
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
        title: Text(_isEditMode ? 'グッズを編集' : 'グッズを追加'),
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
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
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
                        ? const Icon(Icons.add_a_photo, size: 32)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: '商品名 (必須)'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '入力してください' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '金額（円）',
                  hintText: '例: 3000',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: '状態'),
                items: GoodsStatus.labels.entries
                    .map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _status = v);
                },
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

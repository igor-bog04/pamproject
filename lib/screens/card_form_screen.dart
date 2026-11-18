import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/flashcard.dart';
import '../models/cards_model.dart';

class CardFormScreen extends StatefulWidget {
  final int deckId;
  final int? cardId; // null = новая карточка

  const CardFormScreen({super.key, required this.deckId, this.cardId});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _frontCtrl = TextEditingController();
  final _backCtrl = TextEditingController();
  bool _busy = false;

  bool get _isEdit => widget.cardId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final card = context.read<CardsModel>().byId(widget.cardId!);
      if (card != null) {
        _frontCtrl.text = card.front;
        _backCtrl.text = card.back;
      }
    }
  }

  @override
  void dispose() {
    _frontCtrl.dispose();
    _backCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final model = context.read<CardsModel>();
    final messenger = ScaffoldMessenger.of(context);
    final front = _frontCtrl.text.trim();
    final back = _backCtrl.text.trim();

    setState(() => _busy = true);
    final String? error;
    if (_isEdit) {
      final old = model.byId(widget.cardId!);
      error = old == null
          ? 'Карточка не существует'
          : await model.update(old.copyWith(front: front, back: back));
    } else {
      error = await model.add(Flashcard(0, widget.deckId, front, back));
    }
    if (!mounted) return;
    setState(() => _busy = false);

    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(_isEdit ? 'Карточка сохранена' : 'Карточка добавлена'),
      ),
    );
    context.pop();
  }

  String? _required(String? value, String message) =>
      (value == null || value.trim().isEmpty) ? message : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Редактирование карточки' : 'Новая карточка'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _frontCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Лицевая сторона (вопрос)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (v) => _required(v, 'Лицевая сторона обязательна'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _backCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Обратная сторона (ответ)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (v) => _required(v, 'Обратная сторона обязательна'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _busy ? null : _save,
              child: Text(_isEdit ? 'Сохранить' : 'Добавить карточку'),
            ),
          ],
        ),
      ),
    );
  }
}
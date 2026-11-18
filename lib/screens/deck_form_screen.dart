import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/deck.dart';
import '../models/decks_model.dart';

const _subjects = [
  'Языки',
  'Физика',
  'История',
  'Базы данных',
  'Сети',
  'Биология',
  'Программирование',
];

class DeckFormScreen extends StatefulWidget {
  final int? deckId; // null = новая колода

  const DeckFormScreen({super.key, this.deckId});

  @override
  State<DeckFormScreen> createState() => _DeckFormScreenState();
}

class _DeckFormScreenState extends State<DeckFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String? _subject;
  bool _busy = false; // эфемерное состояние: двойной submit

  bool get _isEdit => widget.deckId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final deck = context.read<DecksModel>().byId(widget.deckId!);
      if (deck != null) {
        _nameCtrl.text = deck.name;
        _subject = deck.subject;
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); // кто создаёт, тот освобождает
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return; // валидация L3, нетронута

    final model = context.read<DecksModel>();
    final messenger = ScaffoldMessenger.of(context);
    final name = _nameCtrl.text.trim();

    setState(() => _busy = true);
    final String? error;
    if (_isEdit) {
      final old = model.byId(widget.deckId!);
      error = old == null
          ? 'Колода не существует'
          : await model.update(old.copyWith(name: name, subject: _subject));
    } else {
      error = await model.add(Deck(0, name, _subject!)); // id даст хранилище
    }
    if (!mounted) return; // экран может умереть, пока запрос летит
    setState(() => _busy = false);

    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return; // данные остаются в полях
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          _isEdit ? 'Колода «$name» сохранена' : 'Колода «$name» создана',
        ),
      ),
    );
    context.pop(); // список позади УЖЕ обновился
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Редактирование колоды' : 'Новая колода'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(40)],
              decoration: const InputDecoration(
                labelText: 'Название колоды',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Название обязательно';
                if (text.length < 3) return 'Минимум 3 символа';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _subject,
              decoration: const InputDecoration(
                labelText: 'Предмет',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final s in _subjects)
                  DropdownMenuItem(value: s, child: Text(s)),
              ],
              onChanged: (value) => setState(() => _subject = value),
              validator: (value) => value == null ? 'Выберите предмет' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _busy ? null : _save,
              child: Text(_isEdit ? 'Сохранить' : 'Создать колоду'),
            ),
          ],
        ),
      ),
    );
  }
}
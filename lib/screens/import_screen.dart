import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/cards_model.dart';

class ImportScreen extends StatefulWidget {
  final int deckId;
  const ImportScreen({super.key, required this.deckId});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textCtrl = TextEditingController();
  bool _busy = false;
  List<(String, String)> _cards = [];
  

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  List<String> _split(String line) =>
      line.split(RegExp(r'[,\t]')).map((s) => s.trim()).toList();

  String? _validate(String? value) {
    final lines = (value ?? '').split('\n');
    var count = 0;
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      count++;
      final parts = _split(line);
      if (parts.length < 2 || parts[0].isEmpty || parts[1].isEmpty) {
        return 'Строка ${i + 1}: нужно минимум 2 непустые колонки';
      }
    }
    if (count == 0) return 'Вставьте хотя бы одну строку';
    return null;
  }

  void _preview() {
    if (!_formKey.currentState!.validate()) return;
    final cards = <(String, String)>[];
    for (final line in _textCtrl.text.split('\n')) {
      if (line.trim().isEmpty) continue;
      final parts = _split(line);
      cards.add((parts[0], parts[1]));
    }
    setState(() => _cards = cards);
  }

  Future<void> _import() async {
  final model = context.read<CardsModel>();
  final messenger = ScaffoldMessenger.of(context);
  final count = _cards.length;

  setState(() => _busy = true);
  final error = await model.addAll(widget.deckId, _cards);
  if (!mounted) return;
  setState(() => _busy = false);

  if (error != null) {
    messenger.showSnackBar(SnackBar(content: Text(error)));
    return; // текст остаётся в поле
  }
  messenger.showSnackBar(
    SnackBar(content: Text('Импортировано карточек: $count')),
  );
  context.pop();
}

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Импорт карточек')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Вставьте текст: одна карточка на строку, '
              'вопрос и ответ через запятую или Tab.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _textCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
              onChanged: (_) {
                if (_cards.isNotEmpty) setState(() => _cards = []);
              },
              decoration: const InputDecoration(
                hintText: 'to arrive,прибывать\nto borrow,брать взаймы',
                border: OutlineInputBorder(),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Выбор файла появится позже')),
              ),
              icon: const Icon(Icons.upload_file),
              label: const Text('Выбрать CSV-файл'),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: _preview,
              child: const Text('Предпросмотр'),
            ),
            if (_cards.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Предпросмотр: ${_cards.length} карточек',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final pair in _cards)
                Card(
                  child: ListTile(
                    title: Text(pair.$1),
                    subtitle: Text(pair.$2),
                    trailing: Icon(Icons.check_circle, color: scheme.primary),
                  ),
                ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _busy ? null : _import,
                
                child: Text('Импортировать ${_cards.length} карточек'),
                
              ),
            ],
          ],
        ),
      ),
    );
  }
}
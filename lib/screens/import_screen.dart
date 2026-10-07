import 'package:flutter/material.dart';

const _preview = [
  ('to arrive', 'прибывать'),
  ('to borrow', 'брать взаймы'),
  ('to forget', 'забывать'),
  ('to improve', 'улучшать'),
  ('to suggest', 'предлагать'),
  ('to refuse', 'отказываться'),
];

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Импорт карточек')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Вставьте текст: одна карточка на строку, '
            'вопрос и ответ через запятую или Tab.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const TextField(
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'to arrive,прибывать\nto borrow,брать взаймы',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Выбрать CSV-файл'),
          ),
          const SizedBox(height: 24),
          Text(
            'Предпросмотр: ${_preview.length} карточек',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final pair in _preview)
            Card(
              child: ListTile(
                title: Text(pair.$1),
                subtitle: Text(pair.$2),
                trailing: Icon(Icons.check_circle, color: scheme.primary),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {},
            child: Text('Импортировать ${_preview.length} карточек'),
          ),
        ],
      ),
    );
  }
}
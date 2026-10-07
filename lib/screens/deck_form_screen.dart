import 'package:flutter/material.dart';
import '../data/mock_data.dart';

const _subjects = [
  'Языки',
  'Физика',
  'История',
  'Базы данных',
  'Сети',
  'Биология',
  'Программирование',
];

class DeckFormScreen extends StatelessWidget {
  final Deck? deck; // null = новая колода, иначе редактирование

  const DeckFormScreen({super.key, this.deck});

  @override
  Widget build(BuildContext context) {
    final isEdit = deck != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактирование колоды' : 'Новая колода'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            initialValue: deck?.name,
            decoration: const InputDecoration(
              labelText: 'Название колоды',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownMenu<String>(
            expandedInsets: EdgeInsets.zero,
            label: const Text('Предмет'),
            initialSelection: deck?.subject,
            dropdownMenuEntries: [
              for (final s in _subjects) DropdownMenuEntry(value: s, label: s),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            child: Text(isEdit ? 'Сохранить' : 'Создать колоду'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class CardFormScreen extends StatelessWidget {
  final Flashcard? card; // null = новая карточка

  const CardFormScreen({super.key, this.card});

  @override
  Widget build(BuildContext context) {
    final isEdit = card != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактирование карточки' : 'Новая карточка'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            initialValue: card?.front,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Лицевая сторона (вопрос)',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card?.back,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Обратная сторона (ответ)',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            child: Text(isEdit ? 'Сохранить' : 'Добавить карточку'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/stat_tile.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewed = mockSessions.fold<int>(0, (sum, s) => sum + s.reviewed);
    final correct = mockSessions.fold<int>(0, (sum, s) => sum + s.correct);
    final accuracy = (correct * 100 / reviewed).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatTile(label: 'Сессий', value: '${mockSessions.length}'),
                  StatTile(label: 'Повторено', value: '$reviewed'),
                  StatTile(label: 'Правильно', value: '$accuracy%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('История сессий',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final s in mockSessions)
            Card(
              child: ListTile(
                title: Text(s.deckName),
                subtitle: Text('${s.date} · ${s.reviewed} карточек'),
                trailing: Text(
                  '${(s.correct * 100 / s.reviewed).round()}%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
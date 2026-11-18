import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/stats_model.dart';
import '../widgets/error_view.dart';
import '../widgets/stat_tile.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatsModel>();

    final Widget body;
    if (model.isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (model.error != null) {
      body = ErrorView(
        message: model.error!,
        onRetry: () => context.read<StatsModel>().load(),
      );
    } else {
      body = ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatTile(label: 'Сессий', value: '${model.sessions.length}'),
                  StatTile(label: 'Повторено', value: '${model.reviewed}'),
                  StatTile(label: 'Правильно', value: '${model.accuracy}%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('История сессий',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final s in model.sessions)
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
      );
    }

    return Scaffold(appBar: AppBar(title: const Text('Статистика')), body: body);
  }
}
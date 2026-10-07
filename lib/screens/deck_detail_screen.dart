import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';
import '../widgets/stat_tile.dart';

class DeckDetailScreen extends StatelessWidget {
  final int id;

  const DeckDetailScreen({super.key, required this.id});

  Future<void> _confirmDelete(BuildContext context, Deck deck) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Удалить колоду?'),
        content: Text('Колода «${deck.name}» и все её карточки будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Колода «${deck.name}» удалена')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deck = mockDecks.firstWhere((d) => d.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          IconButton(
            onPressed: () => context.push('/decks/${deck.id}/edit'),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () => _confirmDelete(context, deck),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/decks/${deck.id}/cards/new'),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatTile(label: 'Всего', value: '${deck.cardCount}'),
                  StatTile(label: 'К повторению', value: '${deck.dueToday}'),
                  const StatTile(label: 'Точность', value: '82%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.push('/decks/${deck.id}/review'),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Начать повторение'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/decks/${deck.id}/import'),
            icon: const Icon(Icons.upload_file),
            label: const Text('Импорт карточек'),
          ),
          const SizedBox(height: 16),
          Text('Карточки', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final card in mockCards)
            Card(
              child: ListTile(
                title: Text(card.front),
                subtitle: Text(card.back),
                trailing: const Icon(Icons.chevron_right),
                onTap: () =>
                    context.push('/decks/${deck.id}/cards/${card.id}'),
              ),
            ),
        ],
      ),
    );
  }
}
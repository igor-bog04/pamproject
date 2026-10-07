import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/stat_tile.dart';
import 'card_form_screen.dart';
import 'deck_form_screen.dart';
import 'import_screen.dart';
import 'review_screen.dart';

class DeckDetailScreen extends StatelessWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          IconButton(
            onPressed: () => _open(context, DeckFormScreen(deck: deck)),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _open(context, const CardFormScreen()),
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
            onPressed: () => _open(context, const ReviewScreen()),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Начать повторение'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _open(context, const ImportScreen()),
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
                onTap: () => _open(context, CardFormScreen(card: card)),
              ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/deck.dart';
import '../models/cards_model.dart';
import '../models/decks_model.dart';
import '../widgets/error_view.dart';
import '../widgets/stat_tile.dart';

class DeckDetailScreen extends StatefulWidget {
  final int id;

  const DeckDetailScreen({super.key, required this.id});

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  @override
  void initState() {
    super.initState();
    // загрузка карточек этой колоды — после первого кадра (не во время build)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<CardsModel>().load(widget.id);
    });
  }

  Future<void> _confirmDelete(Deck deck) async {
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
    if (ok != true || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final error = await context.read<DecksModel>().remove(deck.id);
    if (!mounted) return; // экран может умереть, пока «запрос» летит
    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    messenger.showSnackBar(
      SnackBar(content: Text('Колода «${deck.name}» удалена')),
    );
    context.pop(); // объекта больше нет — его экран уходит из стека
  }

  List<Widget> _cardsSection() {
    final cards = context.watch<CardsModel>();
    if (cards.deckId != widget.id || cards.isLoading) {
      return const [
        Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }
    if (cards.error != null) {
      return [
        ErrorView(
          message: cards.error!,
          onRetry: () => context.read<CardsModel>().load(widget.id),
        ),
      ];
    }
    if (cards.cards.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('В колоде пока нет карточек'),
        ),
      ];
    }
    return [
      for (final card in cards.cards)
        Card(
          child: ListTile(
            title: Text(card.front),
            subtitle: Text(card.back),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/decks/${widget.id}/cards/${card.id}'),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final decks = context.watch<DecksModel>();
    final deck = decks.byId(widget.id);

    if (deck == null) {
      // spinner — ровно пока список грузится; иначе id-а нет
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: decks.isLoading
              ? const CircularProgressIndicator()
              : const Text('Колода не существует'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          IconButton(
            onPressed: () => context.push('/decks/${deck.id}/edit'),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () => _confirmDelete(deck),
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
          ..._cardsSection(),
        ],
      ),
    );
  }
}
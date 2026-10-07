import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'due_badge.dart';

class DeckCard extends StatelessWidget {
  final Deck deck;
  final VoidCallback? onTap;
  const DeckCard({super.key, required this.deck, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(deck.name),
        subtitle: Text('${deck.subject} · ${deck.cardCount} карточек'),
        trailing: deck.dueToday > 0 ? DueBadge(count: deck.dueToday) : null,
      ),
    );
  }
}
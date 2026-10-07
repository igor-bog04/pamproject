import 'package:flutter/material.dart';

void main() {
  runApp(const QuickCardsApp());
}

class QuickCardsApp extends StatelessWidget {
  const QuickCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickCards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DecksScreen(),
    );
  }
}

// Временная модель колоды — пока просто класс с полями,
// позже (на L4) заменим на настоящую модель с Repository
class Deck {
  final String name;
  final String subject;
  final int cardCount;
  final int dueToday;

  const Deck({
    required this.name,
    required this.subject,
    required this.cardCount,
    required this.dueToday,
  });
}

// "Зашитые" тестовые данные — временно, вместо реального backend
const List<Deck> mockDecks = [
  Deck(name: 'Английский A2', subject: 'Языки', cardCount: 48, dueToday: 12),
  Deck(name: 'Формулы по физике', subject: 'Физика', cardCount: 25, dueToday: 5),
  Deck(name: 'История Молдовы', subject: 'История', cardCount: 60, dueToday: 0),
];

class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои колоды'),
      ),
      body: ListView.builder(
        itemCount: mockDecks.length,
        itemBuilder: (context, index) {
          final deck = mockDecks[index];
          return ListTile(
            title: Text(deck.name),
            subtitle: Text('${deck.subject} · ${deck.cardCount} карточек'),
            trailing: deck.dueToday > 0
                ? CircleAvatar(
                    radius: 14,
                    child: Text(
                      '${deck.dueToday}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
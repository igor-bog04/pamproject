import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/card_repository.dart';
import 'data/deck_repository.dart';
import 'data/mock_card_repository.dart';
import 'data/mock_deck_repository.dart';
import 'data/mock_session_repository.dart';
import 'data/mock_store.dart';
import 'data/session_repository.dart';
import 'models/cards_model.dart';
import 'models/decks_model.dart';
import 'models/stats_model.dart';
import 'router.dart';

void main() {
  // КОРЕНЬ КОМПОЗИЦИИ: здесь (и только здесь) выбирается источник данных.
  // На L5 заменятся три строки ниже — экраны и модели не меняются.
  final store = MockStore();
  final DeckRepository deckRepo = MockDeckRepository(store);
  final CardRepository cardRepo = MockCardRepository(store);
  final SessionRepository sessionRepo = MockSessionRepository(store);

  runApp(
    MultiProvider(
      providers: [
        // леса демонстрации аварии — исчезнут на L5 вместе с mock-ом
        Provider<MockStore>.value(value: store),
        ChangeNotifierProvider(create: (_) => DecksModel(deckRepo)..load()),
        ChangeNotifierProvider(
          create: (ctx) => CardsModel(
            cardRepo,
            onChanged: ctx.read<DecksModel>().refresh,
          ),
        ),
        ChangeNotifierProvider(create: (_) => StatsModel(sessionRepo)..load()),
      ],
      child: const QuickCardsApp(),
    ),
  );
}

class QuickCardsApp extends StatelessWidget {
  const QuickCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QuickCards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      routerConfig: router,
    );
  }
}
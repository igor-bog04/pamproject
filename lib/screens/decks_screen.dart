import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/decks_model.dart';
import '../widgets/deck_card.dart';
import '../widgets/error_view.dart';

class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DecksModel>(); // watch в build

    final Widget body;
    if (model.isLoading) {
      body = const Center(child: CircularProgressIndicator()); // 1) грузится
    } else if (model.error != null) {
      body = ErrorView(
        message: model.error!, // 2) упало
        onRetry: () => context.read<DecksModel>().load(), // read в callback
      );
    } else if (model.decks.isEmpty) {
      body = const Center(child: Text('Колод пока нет — создайте первую'));
    } else {
      body = ListView.separated(
        // 3) данные
        padding: const EdgeInsets.all(16),
        itemCount: model.decks.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final deck = model.decks[index];
          return DeckCard(
            deck: deck,
            onTap: () => context.push('/decks/${deck.id}'),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Мои колоды')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/decks/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Поиск колод',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
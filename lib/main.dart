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

class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои колоды'),
      ),
      body: const Center(
        child: Text('Здесь будет список колод'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(const QuickCardsApp());

class QuickCardsApp extends StatelessWidget {
  const QuickCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickCards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
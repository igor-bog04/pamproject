import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Повторение')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LinearProgressIndicator(value: 0.25),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Карточка 3 из 12', style: textTheme.bodySmall),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('to improve', style: textTheme.headlineMedium),
                        const SizedBox(height: 16),
                        Text(
                          'Нажмите, чтобы показать ответ',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Показать ответ'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Снова'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () {},
                      child: const Text('Хорошо'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Легко'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
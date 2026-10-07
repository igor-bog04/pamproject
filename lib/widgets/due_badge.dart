import 'package:flutter/material.dart';

class DueBadge extends StatelessWidget {
  final int count;
  const DueBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 14,
      backgroundColor: scheme.primaryContainer,
      child: Text(
        '$count',
        style: TextStyle(fontSize: 12, color: scheme.onPrimaryContainer),
      ),
    );
  }
}
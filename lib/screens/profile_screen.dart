import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/mock_store.dart';
import '../models/decks_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _simulateError; // эфемерное состояние -> setState

  @override
  void initState() {
    super.initState();
    _simulateError = context.read<MockStore>().simulateError;
  }

  Future<void> _logout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Нет'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Да, выйти'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      context.go('/login'); // go: раздел с вкладками уходит из стека
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final decks = context.watch<DecksModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: scheme.primaryContainer,
              child: Text(
                'IB',
                style: textTheme.headlineSmall
                    ?.copyWith(color: scheme.onPrimaryContainer),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('Igor Bogaci',
              textAlign: TextAlign.center, style: textTheme.titleLarge),
          Text('igor@example.com',
              textAlign: TextAlign.center, style: textTheme.bodyMedium),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.style),
                  title: const Text('Колод'),
                  trailing: Text('${decks.decks.length}'),
                ),
                ListTile(
                  leading: const Icon(Icons.layers_outlined),
                  title: const Text('Карточек'),
                  trailing: Text('${decks.totalCards}'),
                ),
                const ListTile(
                  leading: Icon(Icons.local_fire_department_outlined),
                  title: Text('Серия дней подряд'),
                  trailing: Text('6'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // леса демонстрации аварии: умирают на L5 вместе с mock-ом
          SwitchListTile(
            title: const Text('Симулировать сбой сети'),
            value: _simulateError,
            onChanged: (value) {
              setState(() => _simulateError = value);
              context.read<MockStore>().simulateError = value;
            },
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Выйти из аккаунта'),
          ),
        ],
      ),
    );
  }
}
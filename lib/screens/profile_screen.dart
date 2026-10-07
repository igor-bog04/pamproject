import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.style),
                  title: Text('Колод'),
                  trailing: Text('8'),
                ),
                ListTile(
                  leading: Icon(Icons.layers_outlined),
                  title: Text('Карточек'),
                  trailing: Text('280'),
                ),
                ListTile(
                  leading: Icon(Icons.local_fire_department_outlined),
                  title: Text('Серия дней подряд'),
                  trailing: Text('6'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Выйти из аккаунта'),
          ),
        ],
      ),
    );
  }
}
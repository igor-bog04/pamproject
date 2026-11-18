import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/decks_model.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          NavigationDestination(
            icon: Consumer<DecksModel>(
              builder: (context, decks, child) => Badge(
                isLabelVisible: decks.totalDue > 0,
                label: Text('${decks.totalDue}'),
                child: child,
              ),
              child: const Icon(Icons.style),
            ),
            label: 'Колоды',
          ),
          const NavigationDestination(
              icon: Icon(Icons.bar_chart), label: 'Статистика'),
          const NavigationDestination(
              icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
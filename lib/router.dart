import 'package:go_router/go_router.dart';
import 'screens/card_form_screen.dart';
import 'screens/deck_detail_screen.dart';
import 'screens/deck_form_screen.dart';
import 'screens/decks_screen.dart';
import 'screens/import_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/review_screen.dart';
import 'screens/stats_screen.dart';
import 'widgets/app_shell.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    // login стоит ВНЕ shell-а: без нижней панели
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/decks',
            builder: (context, state) => const DecksScreen(),
            routes: [
              // фиксированный 'new' ДО ':id', иначе "new" попадёт в :id
              GoRoute(
                path: 'new',
                builder: (context, state) => const DeckFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return DeckDetailScreen(id: id);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      return DeckFormScreen(deckId: id);
                    },
                  ),
                  GoRoute(
        path: 'import',
          builder: (context, state) => ImportScreen(
                  deckId: int.parse(state.pathParameters['id']!),
                     ),
                      ),
                  GoRoute(
                    path: 'review',
                    builder: (context, state) => const ReviewScreen(),
                  ),
                  // 'cards/new' ДО 'cards/:cardId'
               GoRoute(
  path: 'cards/new',
  builder: (context, state) => CardFormScreen(
    deckId: int.parse(state.pathParameters['id']!),
  ),
),
                GoRoute(
  path: 'cards/:cardId',
  builder: (context, state) => CardFormScreen(
    deckId: int.parse(state.pathParameters['id']!),
    cardId: int.parse(state.pathParameters['cardId']!),
  ),
),
                ],
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/stats',
            builder: (context, state) => const StatsScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),
  ],
);
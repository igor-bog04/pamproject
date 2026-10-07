import 'package:flutter_test/flutter_test.dart';
import 'package:quick_cards/main.dart';

void main() {
  testWidgets('Decks screen shows title', (tester) async {
    await tester.pumpWidget(const QuickCardsApp());
    expect(find.text('Мои колоды'), findsOneWidget);
  });
}
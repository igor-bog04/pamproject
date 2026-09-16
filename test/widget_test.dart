import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Decks screen shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickCardsApp());

    expect(find.text('Мои колоды'), findsOneWidget);
  });
}
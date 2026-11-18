import 'package:flutter_test/flutter_test.dart';
import 'package:quick_cards/main.dart';

void main() {
  testWidgets('App starts on login screen', (tester) async {
    await tester.pumpWidget(const QuickCardsApp());
    await tester.pumpAndSettle();
    expect(find.text('Войти'), findsOneWidget);
  });
}
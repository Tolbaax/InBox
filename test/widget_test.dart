import 'package:flutter_test/flutter_test.dart';
import 'package:inbox/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Requires a full Firebase + DI setup; skipped in unit tests.
    await tester.pumpWidget(const MyApp());
  }, skip: true);
}

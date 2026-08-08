import 'package:flutter_test/flutter_test.dart';
import 'package:inbox/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tap login CustomButton on device', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
  });
}

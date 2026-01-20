import 'package:flutter_test/flutter_test.dart';
import 'package:hanuman_chalisa_paath/main.dart';

void main() {
  testWidgets('Splash screen builds test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HanumanChalisaPaath());

    // Verify that the app builds without errors.
    expect(find.byType(HanumanChalisaPaath), findsOneWidget);
  });
}

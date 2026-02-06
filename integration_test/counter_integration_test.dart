import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo_and_code/main.dart'; // Import the app's main entry point
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Initialize the integration test framework
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter app end-to-end test', (WidgetTester tester) async {
    // Start the app by pumping the MyApp widget
    await tester.pumpWidget(MyApp());

    // Verify the counter starts at 0 on screen
    expect(find.text('0'), findsOneWidget);

    // Find the FloatingActionButton (assume it has Key 'increment' as we set earlier)
    final Finder fab = find.byKey(const ValueKey('increment'));
    // Tap the FAB
    await tester.tap(fab);
    // Wait for any animations or frames to settle
    await tester.pumpAndSettle();

    // Verify the counter text is now 1
    expect(find.text('1'), findsOneWidget);
  });
}

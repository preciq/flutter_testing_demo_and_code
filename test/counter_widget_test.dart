import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_demo_and_code/main.dart'; // Import your app's main widget

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp());

    // The counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon (Fab) and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // trigger a rebuild

    // Now the counter should be 1
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}

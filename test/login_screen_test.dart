// test/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo_and_code/auth_service.dart';
import 'package:flutter_testing_demo_and_code/login_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  testWidgets('successful login shows welcome message', (
    WidgetTester tester,
  ) async {
    final authService = MockAuthService();
    // Stub the login method to succeed
    when(
      authService.login('alice', 'password123'),
    ).thenAnswer((_) async => true);

    // Pump the LoginScreen widget with the mock AuthService
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authService: authService)),
    );

    // Enter text into the username and password fields
    await tester.enterText(find.byKey(Key('usernameField')), 'alice');
    await tester.enterText(find.byKey(Key('passwordField')), 'password123');
    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    // Wait for the async login Future and UI update
    await tester.pumpAndSettle();

    // The welcome message should be displayed
    expect(find.text('Welcome, alice!'), findsOneWidget);
    // Verify that AuthService.login was called once with the provided credentials
    verify(authService.login('alice', 'password123')).called(1);
  });

  testWidgets('failed login shows error message', (WidgetTester tester) async {
    final authService = MockAuthService();
    // Stub the login method to return false (failure)
    when(authService.login(any, any)).thenAnswer((_) async => false);

    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authService: authService)),
    );
    await tester.enterText(find.byKey(Key('usernameField')), 'bob');
    await tester.enterText(find.byKey(Key('passwordField')), 'wrongpass');
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    expect(find.text('Login failed'), findsOneWidget);
    verify(authService.login('bob', 'wrongpass')).called(1);
  });
}

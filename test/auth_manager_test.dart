// test/auth_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo_and_code/auth_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_testing_demo_and_code/auth_manager.dart';
import 'auth_manager_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  group('AuthManager.attemptLogin', () {
    test('sets isLoggedIn true on successful login', () async {
      final authService = MockAuthService();
      final manager = AuthManager(authService);
      // Stub the AuthService.login to succeed
      when(authService.login('user123', 'pass123')).thenAnswer((_) async => true);
      
      await manager.attemptLogin('user123', 'pass123');
      
      // Verify state on success
      expect(manager.isLoggedIn, true);
      expect(manager.errorMessage, isNull);
      // Also verify that login() was called with the correct arguments
      verify(authService.login('user123', 'pass123')).called(1);
    });
    
    test('sets errorMessage on login failure (wrong credentials)', () async {
      final authService = MockAuthService();
      final manager = AuthManager(authService);
      // Stub login to return false (e.g., invalid credentials)
      when(authService.login(any, any)).thenAnswer((_) async => false);
      
      await manager.attemptLogin('foo', 'bar');
      
      expect(manager.isLoggedIn, false);
      expect(manager.errorMessage, equals("Login failed"));
      // Ensure AuthService.login was called once (with any arguments in this case)
      verify(authService.login(any, any)).called(1);
    });
    
    test('handles exceptions from AuthService.login', () async {
      final authService = MockAuthService();
      final manager = AuthManager(authService);
      // Stub login to throw an exception (simulate network issue)
      when(authService.login(any, any)).thenThrow(Exception('network error'));
      
      await manager.attemptLogin('user123', 'pass123');
      
      expect(manager.isLoggedIn, false);
      expect(manager.errorMessage, contains('network error'));
      verify(authService.login('user123', 'pass123')).called(1);
    });
  });
}

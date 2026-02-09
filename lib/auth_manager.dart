import 'package:flutter_testing_demo_and_code/auth_service.dart';

class AuthManager {
  final AuthService authService;
  bool isLoggedIn = false;
  String? errorMessage;

  AuthManager(this.authService);

  // Attempts to login and sets state based on result
  Future<void> attemptLogin(String username, String password) async {
    try {
      final success = await authService.login(username, password);
      if (success) {
        isLoggedIn = true;
        errorMessage = null;
      } else {
        isLoggedIn = false;
        errorMessage = "Login failed";
      }
    } catch (e) {
      // Handle exceptions from AuthService (e.g., network error)
      isLoggedIn = false;
      errorMessage = "Error: ${e.toString()}";
    }
  }
}

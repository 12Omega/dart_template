import 'dart:async';

class AuthService {
  final StreamController<bool> _authStatusController = StreamController<bool>.broadcast();
  Stream<bool> get authStatusStream => _authStatusController.stream;

  Map<String, dynamic>? _currentUser;

  AuthService() {
    _authStatusController.add(false); // Initial status
  }

  Future<bool> isLoggedIn() async {
    // In a real app, check for a stored token. For now, just check if _currentUser is set.
    return _currentUser != null;
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    return _currentUser;
  }

  Map<String, dynamic>? get currentUserData => _currentUser;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'password') {
      _currentUser = {'id': 'user123', 'email': email, 'fullName': 'Test User'};
      _authStatusController.add(true); // Notify listeners of login
      return true;
    }
    _currentUser = null;
    _authStatusController.add(false); // Notify listeners of failed login
    return false;
  }

  Future<bool> register(String fullName, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email != 'test@example.com') {
      _currentUser = {'id': 'newUser', 'email': email, 'fullName': fullName};
      _authStatusController.add(true); // Notify listeners of registration and login
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStatusController.add(false); // Notify listeners of logout
  }

  void dispose() {
    _authStatusController.close();
  }
}

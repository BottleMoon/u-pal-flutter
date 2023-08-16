import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:u_pal/model/token.dart';
import 'package:u_pal/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  late final AuthRepository _authRepository;
  final storage = const FlutterSecureStorage();
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  AuthViewModel() {
    _authRepository = AuthRepository();
  }

  signIn(String email, String password) async {
    Token? token = await _authRepository.signIn(email, password);
    if (token == null) {
      print("Error signing in");
      return;
    }
    await storage.write(key: "accessToken", value: token.accessToken);
    await storage.write(key: "refreshToken", value: token.refreshToken);
    _isSignedIn = true;
    notifyListeners();
  }

  void logout() async {
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
    _isSignedIn = false;
    notifyListeners();
  }
}

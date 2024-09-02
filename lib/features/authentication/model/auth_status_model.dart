import 'package:flutter/material.dart';

@immutable
abstract class AuthStatus {
  const AuthStatus();
}

@immutable
class AuthStatusLoggedOut implements AuthStatus {
  const AuthStatusLoggedOut();
}

@immutable
class AuthStatusLoggedIn implements AuthStatus {
  final String userEmail;
  const AuthStatusLoggedIn({required this.userEmail,});
}

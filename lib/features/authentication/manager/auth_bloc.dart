
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/core/extensions/stream_loading_extension.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_command_model.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_error_model.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_status_model.dart';
import 'package:flutter_plantist_app/features/authentication/view/entry_page.dart';
import 'package:flutter_plantist_app/features/authentication/view/sign_in_page.dart';
import 'package:flutter_plantist_app/features/home/view/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class AuthBloc {
  // read-only properties
  final Stream<AuthStatus> authStatus;
  final Stream<AuthError?> authError;
  final Stream<bool> isLoading;
  final Stream<String?> userId;
  // write-only properties
  final Sink<LoginCommand> login;
  final Sink<RegisterCommand> register;
  final Sink<void> logout;
  final Sink<void> deleteAccount;

  void dispose() {
    login.close();
    register.close();
    logout.close();
    deleteAccount.close();
  }

  const AuthBloc._({
    required this.authStatus,
    required this.authError,
    required this.isLoading,
    required this.userId,
    required this.login,
    required this.register,
    required this.logout,
    required this.deleteAccount,
  });

  factory AuthBloc() {
    final isLoading = BehaviorSubject<bool>.seeded(false);

    // calculate auth status
    final Stream<AuthStatus> authStatus =
        FirebaseAuth.instance.authStateChanges().map((user) {
      if (user != null) {
        return AuthStatusLoggedIn(userEmail: user.email!);
      } else {
        return const AuthStatusLoggedOut();
      }
    });

    // get the user-id
    final Stream<String?> userId = FirebaseAuth.instance
        .authStateChanges()
        .map((user) => user?.uid)
        .startWith(FirebaseAuth.instance.currentUser?.uid);

    // login + error handling
    final login = BehaviorSubject<LoginCommand>();

    final Stream<AuthError?> loginError = login
    .setLoadingTo(true, onSink:isLoading )
        .asyncMap<AuthError?>((loginCommand) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginCommand.email,
          password: loginCommand.password,
        );
        // going to home;
        globalCtx.push(HomePage.routeName);
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // register + error handling
    final register = BehaviorSubject<RegisterCommand>();

    final Stream<AuthError?> registerError = register
        .setLoadingTo(true, onSink: isLoading)
        .asyncMap<AuthError?>((registerCommand) async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerCommand.email,
          password: registerCommand.password,
        );
        // going to home;
        globalCtx.push(HomePage.routeName);
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // logout + error handling
    final logout = BehaviorSubject<void>();

    final Stream<AuthError?> logoutError = logout
        .setLoadingTo(true, onSink: isLoading)
        .asyncMap<AuthError?>((_) async {
      try {
        await FirebaseAuth.instance.signOut();
        globalCtx.go(SignInPage.routeName);
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // delete account

    final deleteAccount = BehaviorSubject<void>();

    final Stream<AuthError?> deleteAccountError =
        deleteAccount.setLoadingTo(true, onSink: isLoading).asyncMap((_) async {
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        globalCtx.go(SignInPage.routeName);
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // auth error = (login error + register error + logout error)

    final Stream<AuthError?> authError = Rx.merge([
      loginError,
      registerError,
      logoutError,
      deleteAccountError,
    ]);

  //   login.listen((loginCommand){
  //     log(loginCommand.email);
  // });

    return AuthBloc._(
      authStatus: authStatus,
      authError: authError,
      isLoading: isLoading,
      userId: userId,
      login: login,
      register: register,
      logout: logout,
      deleteAccount: deleteAccount,
    );
  }
}

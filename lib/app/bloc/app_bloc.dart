import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_plantist_app/app/dialogs/auth_error_dialog.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/core/loading_overlays/loading_screen.dart';
import 'package:flutter_plantist_app/features/authentication/manager/auth_bloc.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_command_model.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_error_model.dart';
import 'package:flutter_plantist_app/features/home/manager/photo_bloc.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:flutter_plantist_app/main.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class AppBloc {
  final AuthBloc _authBloc;
  final PhotosBloc _photosBloc;

  final Stream<bool> isLoading;
  final Stream<AuthError?> authError;
  final StreamSubscription<String?> _userIdChanges;

  factory AppBloc() {
    final authBloc = AuthBloc();
    final photosBloc = PhotosBloc();

    // pass userid from auth bloc into the photos bloc

    final userIdChanges = authBloc.userId.listen((String? userId) {
      photosBloc.userId.add(userId);
    });

    // isLoading

    final Stream<bool> isLoading = Rx.merge([
      authBloc.isLoading,
    ]);

    return AppBloc._(
      authBloc: authBloc,
      photosBloc: photosBloc,
      isLoading: isLoading.asBroadcastStream(),
      authError: authBloc.authError.asBroadcastStream(),
      userIdChanges: userIdChanges,
    );
  }

  void dispose() {
    _authBloc.dispose();
    _photosBloc.dispose();
    _userIdChanges.cancel();
  }

  const AppBloc._({
    required AuthBloc authBloc,
    required PhotosBloc photosBloc,
    required this.isLoading,
    required this.authError,
    required StreamSubscription<String?> userIdChanges,
  })  : _authBloc = authBloc,
        _photosBloc = photosBloc,
        _userIdChanges = userIdChanges;

  void deletePhoto(Photo photo) {
    _photosBloc.deletePhoto.add(
      photo,
    );
  }

  void createPhoto(
    File imageUrl,
    String? caption,
  ) {
    _photosBloc.createPhoto.add(
      Photo.withoutId(
        image: imageUrl,
        caption: caption ?? "",
      ),
    );
  }

  void deleteAccount() {
    _photosBloc.deleteAllPhotos.add(null);
    _authBloc.deleteAccount.add(null);
  }

  void logout() {
    _authBloc.logout.add(
      null,
    );
  }

  Stream<Iterable<Photo>> get photoList => _photosBloc.photos;

  void register(
    String email,
    String password,
  ) {
    _authBloc.register.add(
      RegisterCommand(
        email: email,
        password: password,
      ),
    );
  }

  void login(
    String email,
    String password,
  ) {
    log("app bloc a geliyor mu? $email $password");

    _authBloc.login.add(
      LoginCommand(
        email: email,
        password: password,
      ),
    );
  }
}

void handleAuthErrors() async {
  appBloc.authError.listen((event) {
    final Object? authError = event;
    if (authError == null) {
      return;
    }
    showAuthError(
      authError: authError as AuthError,
      context: globalCtx,
    );
  });
}

void setupLoadingScreen() async {
  appBloc.isLoading.listen((bool isLoading) {
    if (isLoading) {
      LoadingScreen.instance().show(
        context: globalCtx,
        text: 'Loading...',
      );
    } else {
      LoadingScreen.instance().hide();
    }
  });
}

AppBloc get appBloc => locator<AppBloc>();

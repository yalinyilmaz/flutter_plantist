import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/features/authentication/view/entry_page.dart';
import 'package:flutter_plantist_app/features/authentication/view/sign_in_page.dart';
import 'package:flutter_plantist_app/features/authentication/view/sign_up_page.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:flutter_plantist_app/features/home/view/home_page.dart';
import 'package:flutter_plantist_app/features/home/view/home_photo_detail_page.dart';
import 'package:go_router/go_router.dart';

BuildContext get globalCtx =>
    router.routerDelegate.navigatorKey.currentContext!;

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const EntryPage(),
      routes: <GoRoute>[
        GoRoute(
            path: SignInPage.routeName.makeGoRouterPath,
            builder: (BuildContext context, GoRouterState state) =>
                const SignInPage()),
        GoRoute(
            path: SignUpPage.routeName.makeGoRouterPath,
            builder: (BuildContext context, GoRouterState state) =>
                const SignUpPage()),
        GoRoute(
            path: HomePage.routeName.makeGoRouterPath,
            builder: (BuildContext context, GoRouterState state) =>
                const HomePage()),
        GoRoute(
            path: PhotoDetailsPage.routeName.makeGoRouterPath,
            builder: (BuildContext context, GoRouterState state) {
              final photo = state.extra as Photo;
              return PhotoDetailsPage(photo: photo);
            })
      ],
    ),
  ],
);

extension GoRouterExt on String {
  String get makeGoRouterPath => substring(1);
}

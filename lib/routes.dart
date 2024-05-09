import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/pages/home_page.dart';
import 'package:flutter_plantist_app/view/pages/sign_in_page.dart';
import 'package:flutter_plantist_app/view/pages/sign_up_page.dart';
import 'package:flutter_plantist_app/view/pages/todo_list_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
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
            path: TodoListPage.routeName.makeGoRouterPath,
            builder: (BuildContext context, GoRouterState state) =>
                const TodoListPage())
      ],
    ),
  ],
);

extension GoRouterExt on String {
  String get makeGoRouterPath => substring(1);
}


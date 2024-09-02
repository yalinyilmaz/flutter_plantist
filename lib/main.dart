import 'dart:ui';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/firebase_options.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_overlay/loading_overlay.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppBloc());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(const PlantistApp());
}

class PlantistApp extends StatelessWidget {
  const PlantistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Plantist App',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return StreamBuilder<bool>(
          stream: appBloc.isLoading,
          builder: (context, snapshot) {
            final isLoading = snapshot.hasData ? snapshot.requireData : false;
            return LoadingOverlay(
              isLoading: isLoading,
              child: child!,
            );
          },
        );
      },
    );
  }
}

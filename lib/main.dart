import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/firebase_options.dart';
import 'package:flutter_plantist_app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
    );
  }
}



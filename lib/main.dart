import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/routes.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:flutter_plantist_app/view/pages/home_page.dart';

void main() {
  runApp(const PlantistApp());
}

class PlantistApp extends StatelessWidget {
  const PlantistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Plantist App',
      //theme: Themes.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}



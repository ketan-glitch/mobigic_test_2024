import 'package:flutter/material.dart';
import 'package:mobigic_test_2024/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

Color primaryColor = const Color(0xFFFFCA0E);
const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff838383);

Map<int, Color> color = const {
  50: Color.fromRGBO(255, 202, 14, .1),
  100: Color.fromRGBO(255, 202, 14, .2),
  200: Color.fromRGBO(255, 202, 14, .3),
  300: Color.fromRGBO(255, 202, 14, .4),
  400: Color.fromRGBO(255, 202, 14, .5),
  500: Color.fromRGBO(255, 202, 14, .6),
  600: Color.fromRGBO(255, 202, 14, .7),
  700: Color.fromRGBO(255, 202, 14, .8),
  800: Color.fromRGBO(255, 202, 14, .9),
  900: Color.fromRGBO(255, 202, 14, 1.0),
};
MaterialColor colorCustom = MaterialColor(0xFFFFCA0E, color);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobigic Test',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: colorCustom,
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}

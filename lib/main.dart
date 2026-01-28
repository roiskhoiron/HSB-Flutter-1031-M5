import 'package:flutter/material.dart';
import 'routes.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/home_page2.dart';
import 'pages/home_page_splash.dart';
import 'pages/home_page_main.dart';

void main() {
  runApp(const HabitlyApp());
}

class HabitlyApp extends StatelessWidget {
  const HabitlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habitly',
      initialRoute: AppRoutes.loginsplash,
      routes: {
        AppRoutes.loginsplash: (context) => const SplashPage(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.homePage2: (context) => const HomePage2(),
        AppRoutes.homeSplashPage: (context) => const HomeSplashPage(),
        AppRoutes.homePageMain: (context) => const HomePageMain(),
      },
    );
  }
}
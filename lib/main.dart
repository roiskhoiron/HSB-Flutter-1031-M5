import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mission_5_habbits/pages/add_habit.dart';
import 'package:mission_5_habbits/models/habit.dart';

import 'routes.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/home_page2.dart';
import 'pages/home_page_splash.dart';
import 'pages/home_page_main.dart';
import 'theme/app_theme.dart';
import 'pages/add_habit.dart';

// themeNotifier sebagai global variable – lebih baik dikelola melalui Riverpod provider.
//{Inline Review: Gunakan provider untuk theme agar state management konsisten satu pola.}
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  //{Inline Review: Tambahkan guard adapter registration untuk mencegah duplicate registration error.}
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habitsBox');

  runApp(const ProviderScope(
    child: HabitlyApp(),
    ),
  );
}

class HabitlyApp extends StatelessWidget {
  const HabitlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habitly',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,

          initialRoute: AppRoutes.loginsplash,

          routes: {
            AppRoutes.loginsplash: (context) => const SplashPage(),
            AppRoutes.login: (context) => const LoginPage(),
            AppRoutes.register: (context) => const RegisterPage(),
            AppRoutes.home: (context) => const HomePage(),
            AppRoutes.homePage2: (context) => const HomePage2(),
            AppRoutes.homeSplashPage: (context) => const HomeSplashPage(),
            AppRoutes.homePageMain: (context) => const HomePageMain(),
            // AppRoutes.addHabitPage: (context) => AddHabit(),
          },
        );
      },
    );
  }
}

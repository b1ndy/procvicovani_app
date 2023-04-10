import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/choose_class_screen.dart';
import 'screens/flash_cards_screen.dart';
import 'screens/choose_practice_type.dart';
import 'screens/homepage_screen.dart';
import 'screens/choose_lectures_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/reset_choose_lectures_screen.dart';
import 'screens/reset_choose_class_screen.dart';
import "screens/choose_one_screen.dart";
import 'screens/writing_screen.dart';

void main() {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProcvicSlov',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          hoverColor: Colors.lightBlue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade700,
          ),
        ),
        toggleableActiveColor: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const HomepageScreen(),
        SettingsScreen.routeName: (ctx) => const SettingsScreen(),
        ChooseLecturesScreen.routeName: (ctx) => const ChooseLecturesScreen(),
        ChoosePracticeType.routeName: (ctx) => const ChoosePracticeType(),
        FlashCardsScreen.routeName: (ctx) => const FlashCardsScreen(),
        ChooseClassScreen.routeName: (ctx) => const ChooseClassScreen(),
        ResetChooseLecturesScreen.routeName: (ctx) =>
            const ResetChooseLecturesScreen(),
        ResetChooseClassScreen.routeName: (ctx) =>
            const ResetChooseClassScreen(),
        ChooseOneScreen.routeName: (ctx) => const ChooseOneScreen(),
        WritingScreen.routeName: (ctx) => const WritingScreen(),
      },
    );
  }
}

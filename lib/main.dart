import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procvicovani_app/screens/choose_practice_type.dart';

import './screens/homepage_screen.dart';
import './screens/choose_unit_screen.dart';
import './screens/settings_screen.dart';

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade700,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const HomepageScreen(),
        SettingsScreen.routeName: (ctx) => const SettingsScreen(),
        ChooseUnitScreen.routeName: (ctx) => const ChooseUnitScreen(),
        ChoosePracticeType.routeName: (ctx) => const ChoosePracticeType(),
      },
    );
  }
}

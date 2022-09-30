import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

import '../data/vocabulary.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    print(vocabulary["Introduction"]!["B The exchange students"]);

    return Scaffold(
      appBar: MyAppBar("Nastavení"),
    );
  }
}

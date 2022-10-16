import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Nastavení"),
    );
  }
}

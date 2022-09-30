import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class ChooseUnitScreen extends StatelessWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Vyber Lekci"),
    );
  }
}

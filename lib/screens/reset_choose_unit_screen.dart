import 'package:flutter/material.dart';

import '../widgets/class_button.dart';
import '../widgets/my_app_bar.dart';

class ResetChooseUnitScreen extends StatelessWidget {
  const ResetChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-reset-unit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber třídu"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ClassButton(
            "6. třída",
            "/reset-unit",
            "sixClassVocab",
          ),
        ],
      ),
    );
  }
}

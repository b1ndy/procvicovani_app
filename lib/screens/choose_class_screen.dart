import 'package:flutter/material.dart';

import '../widgets/default_button.dart';
import '../widgets/my_app_bar.dart';

class ChooseClassScreen extends StatelessWidget {
  const ChooseClassScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-class";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber procvičování"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          DefaultButton(
            "6. třída",
            "/choose-unit",
          ),
        ],
      ),
    );
  }
}

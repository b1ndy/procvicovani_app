import 'package:flutter/material.dart';

import '../widgets/button_with_icon.dart';
import '../widgets/my_app_bar.dart';

class ChoosePracticeType extends StatelessWidget {
  const ChoosePracticeType({Key? key}) : super(key: key);
  static const routeName = "/choose-practice";

  @override
  Widget build(BuildContext context) {
    final _practiceVocab = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber procvičování"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWithIcon(
            "Flash cards",
            "/flash-cards",
            "Ve Flash cards... bla bla...",
            _practiceVocab,
          ),
        ],
      ),
    );
  }
}

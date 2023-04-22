import 'package:flutter/material.dart';
import '../data/instructions.dart';
import '../widgets/button_with_icon.dart';
import '../widgets/my_app_bar.dart';

class ChoosePracticeTypeScreen extends StatelessWidget {
  const ChoosePracticeTypeScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-practice";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber procvičování"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ButtonWithIcon(
            "Flash cards",
            "/flash-cards",
            flashCardsInfo,
          ),
          ButtonWithIcon(
            "Choose one",
            "/choose-one",
            chooseOneInfo,
          ),
          ButtonWithIcon(
            "Writing",
            "/writing",
            writingInfo,
          ),
        ],
      ),
    );
  }
}

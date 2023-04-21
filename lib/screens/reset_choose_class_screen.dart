import 'package:flutter/material.dart';

import './reset_choose_lectures_screen.dart';

import '../widgets/class_button.dart';
import '../widgets/my_app_bar.dart';

import '../data/vocab_register.dart';

class ResetChooseClassScreen extends StatelessWidget {
  const ResetChooseClassScreen({Key? key}) : super(key: key);
  static const routeName = "/reset-choose-class";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber třídu"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: vocabRegister.keys
            .map<Widget>((key) =>
                ClassButton(key[1], ResetChooseLecturesScreen.routeName, key))
            .toList(),

        // const [
        //   ClassButton(
        //     "6. třída",
        //     ResetChooseLecturesScreen.routeName,
        //     "sixClassVocab",
        //   ),
        // ],
      ),
    );
  }
}

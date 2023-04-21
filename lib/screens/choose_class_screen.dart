import 'package:flutter/material.dart';
import 'package:procvicovani_app/data/vocab_register.dart';

import './choose_lectures_screen.dart';

import '../widgets/class_button.dart';
import '../widgets/my_app_bar.dart';

class ChooseClassScreen extends StatelessWidget {
  const ChooseClassScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-class";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar("Vyber třídu"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: vocabRegister.keys
            .map<Widget>((key) =>
                ClassButton(key[1], ChooseLecturesScreen.routeName, key))
            .toList(),

        // const [
        //   ClassButton(
        //     "6. třída",
        //     ChooseLecturesScreen.routeName,
        //     "sixClassVocab",
        //   ),
        //   ClassButton(
        //     "test",
        //     ChooseLecturesScreen.routeName,
        //     "test_vocab",
        //   ),
        // ],
      ),
    );
  }
}

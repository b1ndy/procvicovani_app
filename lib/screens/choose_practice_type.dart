import 'package:flutter/material.dart';
import 'package:procvicovani_app/widgets/button_with_icon.dart';

import '../widgets/my_app_bar.dart';

class ChoosePracticeType extends StatelessWidget {
  const ChoosePracticeType({Key? key}) : super(key: key);
  static const routeName = "/choose-practice";

  @override
  Widget build(BuildContext context) {
    final _practiceVocab = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: MyAppBar("Vyber Procvičování"),
      body: const ButtonWithIcon(
        "Test",
        "/",
        "V Testu bla bla...",
      ),
    );
  }
}

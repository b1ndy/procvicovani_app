import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class ChoosePracticeType extends StatelessWidget {
  const ChoosePracticeType({Key? key}) : super(key: key);
  static const routeName = "/choose-practice";

  @override
  Widget build(BuildContext context) {
    final _practiceVocab = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: MyAppBar("xxx"),
      body: Text(_practiceVocab[0][0]),
    );
  }
}

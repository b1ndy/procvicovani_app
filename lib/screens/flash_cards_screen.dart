import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class FlashCardsScreen extends StatelessWidget {
  const FlashCardsScreen({Key? key}) : super(key: key);
  static const routeName = "/flash-cards";

  @override
  Widget build(BuildContext context) {
    final _practiceVocab = ModalRoute.of(context)!.settings.arguments as List;
    print(_practiceVocab);
    return Scaffold(
      appBar: MyAppBar(""),
      body: Text(_practiceVocab[0][0]),
    );
  }
}

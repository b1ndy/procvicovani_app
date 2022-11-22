import 'package:flutter/material.dart';

import '../data/data_service_class.dart' as cs;

class ClassButton extends StatelessWidget {
  final String text;
  final String route;
  final Map chosenVocab;

  // ignore: use_key_in_widget_constructors
  const ClassButton(
    this.text,
    this.route,
    this.chosenVocab,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: ElevatedButton(
        child: Text(text),
        onPressed: () {
          cs.classService.fillVocabList(chosenVocab);
          Navigator.pushNamed(
            context,
            route,
          );
        },
      ),
    );
  }
}

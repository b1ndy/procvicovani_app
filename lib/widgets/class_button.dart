import 'dart:convert';
import 'package:flutter/material.dart';

import '../data/data_service_class.dart' as cs;
import '../data/local_data_service.dart' as lds;

class ClassButton extends StatelessWidget {
  final String text;
  final String route;
  final String chosenVocab;

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
          lds.localDataService.readFromFile(chosenVocab).then((value) {
            if (value != "") {
              cs.classService.fillVocabList(json.decode(value));
              Navigator.pushNamed(
                context,
                route,
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'Tato třída ještě nebyla přidána do naší aplikace.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          });
        },
      ),
    );
  }
}

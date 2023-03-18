import 'dart:convert';
import 'package:flutter/material.dart';

import './reset_choose_class_screen.dart';

import '../widgets/my_app_bar.dart';
import '../widgets/default_button.dart';

import '../data/six_class_vocab.dart';
import '../data/local_data_service.dart' as lds;

//reset progress for each lecture separately

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    //test list

    return Scaffold(
      appBar: MyAppBar("Nastavení"),
      //body - test
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: ElevatedButton(
              child: const Text("Resetovat všechen postup"),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Určitě?'),
                    content: const Text(
                        'Opravdu si přejete resetovat všechen postup?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          lds.localDataService.writeToFile(
                              json.encode(sixClassVocab), "sixClassVocab");
                          Navigator.pop(context);
                        },
                        child: const Text('Ano'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ne'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const DefaultButton(
            "Resetovat pouze některé lekce",
            ResetChooseClassScreen.routeName,
          ),
        ],
      ),
    );
  }
}

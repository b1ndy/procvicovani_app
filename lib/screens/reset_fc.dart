import 'dart:convert';
import 'package:flutter/material.dart';

import './reset_choose_class_screen.dart';

import '../widgets/my_app_bar.dart';
import '../widgets/default_button.dart';

import '../data/vocab_register.dart';
import '../data/local_data_service.dart' as lds;

//reset progress for each lecture separately

class ResetFC extends StatelessWidget {
  const ResetFC({Key? key}) : super(key: key);
  static const routeName = "/reset-fc";

  @override
  Widget build(BuildContext context) {
    //test list

    return Scaffold(
      appBar: MyAppBar("Reset flash cards"),
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
                          vocabRegister.forEach((k, v) {
                            lds.localDataService
                                .writeToFile(json.encode(v), k[0]);
                          });
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

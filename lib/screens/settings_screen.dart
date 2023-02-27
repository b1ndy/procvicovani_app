import 'package:flutter/material.dart';
import '../widgets/my_app_bar.dart';

//import - test
import '../data/six_class_vocab.dart';
import '../data/data_service_class.dart' as cs;
import 'dart:convert';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    //test list

    return Scaffold(
        appBar: MyAppBar("Nastavení"),
        //body - test
        body: ElevatedButton(
            onPressed: (() {
              cs.classService.fillVocabList(sixClassVocab);
              final Map<String, dynamic> _lectureList = sixClassVocab.map((key,
                      value) =>
                  MapEntry(key, value.keys.map((e) => [e, false]).toList()));
              _lectureList["Introduction"]![2][1] = true;

              print(_lectureList);
              print(_lectureList.runtimeType);
              String jsonstringmap = json.encode(_lectureList);
              print(jsonstringmap);
              print(jsonstringmap.runtimeType);
              Map restoredmap = json.decode(jsonstringmap);
              print(restoredmap);
              print(restoredmap.runtimeType);

              cs.classService.fillPracticeVocab(_lectureList);
              List _practiceVocab = cs.classService.getPracticeVocab();
              print(_practiceVocab);

              //save to file
            }),
            child: Text("Push Me")));
  }
}

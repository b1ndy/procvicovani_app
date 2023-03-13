import 'package:flutter/material.dart';
import '../widgets/my_app_bar.dart';

//import - test
import '../data/six_class_vocab.dart';
import 'dart:convert';
import '../data/data_service_class.dart' as cs;
import '../data/local_data_service.dart' as svd;

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
          children: [
            ElevatedButton(
                onPressed: (() {
                  cs.classService.fillVocabList(sixClassVocab);
                  final Map<String, dynamic> _lectureList = sixClassVocab.map(
                      (key, value) => MapEntry(
                          key, value.keys.map((e) => [e, false]).toList()));
                  _lectureList["Introduction"]![2][1] = true;

                  //encode to json string
                  final String _jsonString = json.encode(_lectureList);
                  //save to file
                  svd.localDataService.writeToFile(_jsonString, "myMap");

                  // cs.classService.fillPracticeVocab(_lectureList);
                  // List _practiceVocab = cs.classService.getPracticeVocab();
                  // print(_practiceVocab);

                  //save to file
                }),
                child: const Text("Save File")),
            ElevatedButton(
                onPressed: (() {
                  svd.localDataService
                      .readFromFile("myMap")
                      .then((value) => print(value));
                }),
                child: const Text("Read File")),
            ElevatedButton(
                onPressed: (() {
                  svd.localDataService.writeToFile("", "myMap");
                }),
                child: const Text("Clear File")),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import '../widgets/my_app_bar.dart';

//import - test
import '../data/six_class_vocab.dart';
import '../data/data_service_class.dart' as cs;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  //file functions test
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/testfile.txt');
  }

  Future<File> writeToFile(String myMap) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(myMap);
  }

  Future<String> readFromFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

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

                  String jsonStringMap = json.encode(_lectureList);

                  //save to file
                  writeToFile(jsonStringMap);

                  // cs.classService.fillPracticeVocab(_lectureList);
                  // List _practiceVocab = cs.classService.getPracticeVocab();
                  // print(_practiceVocab);

                  //save to file
                }),
                child: Text("Save File")),
            ElevatedButton(
                onPressed: (() {
                  readFromFile().then((value) => print(value));
                }),
                child: Text("Read File")),
          ],
        ));
  }
}

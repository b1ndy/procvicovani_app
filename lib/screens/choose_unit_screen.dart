import 'dart:convert';
import 'package:flutter/material.dart';

import './choose_practice_type.dart';
import '../data/six_class_vocab.dart';
import '../data/data_service_class.dart' as cs;
import '../data/local_data_service.dart' as lds;

class ChooseUnitScreen extends StatefulWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  State<ChooseUnitScreen> createState() => _ChooseUnitScreenState();
}

class _ChooseUnitScreenState extends State<ChooseUnitScreen> {
  //list of unit and lectures
  final Map<String, List<List>> _lectureList = sixClassVocab.map((key, value) =>
      MapEntry(key, value.keys.map((e) => [e, false]).toList()));

  //builds UnitName with bottom border
  Widget _buildUnitName(String text) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 20,
      ),
      margin: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(146, 92, 92, 92),
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: "Quicksand",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //fills PracticeVocab in DataServiceClass and if its not empty then navigates to next page
  void confirmChoice() {
    final _practiceVocab = cs.classService.fillPracticeVocab(_lectureList);
    if (_practiceVocab == true) {
      Navigator.pushNamed(
        context,
        ChoosePracticeType.routeName,
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Vyber lekci!'),
          content: const Text(
              'Nemáš vybranou žádnou lekci. Vyber jednu nebo více lekcí, které chceš procvičovat, a zkus to znovu.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _unitList = _lectureList.keys.toList();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            lds.localDataService
                .writeToFile(json.encode(cs.classService.getVocabList()),
                    "sixClassVocab")
                .then((value) => Navigator.of(context).pop());
          },
        ),
        title: const Text("Vyber lekci"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 70.0),
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              _buildUnitName(_unitList[index]),
              Column(
                  children: _lectureList[_unitList[index]]!
                      .map((unit) => CheckboxListTile(
                            value: unit[1],
                            onChanged: (value) {
                              setState(() {
                                unit[1] = value!;
                              });
                            },
                            title: Text(
                              unit[0],
                              style: const TextStyle(
                                fontSize: 19,
                              ),
                            ),
                          ))
                      .toList()),
            ],
          );
        },
        itemCount: _lectureList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: confirmChoice,
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';

import 'choose_practice_type_screen.dart';

import '../data/vocab_register.dart';
import '../data/data_service_class.dart' as dsc;
import '../data/local_data_service.dart' as lds;

class ChooseLecturesScreen extends StatefulWidget {
  const ChooseLecturesScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-lectures";

  @override
  State<ChooseLecturesScreen> createState() => _ChooseLecturesScreenState();
}

class _ChooseLecturesScreenState extends State<ChooseLecturesScreen> {
  //list of units and lectures
  Map _lectureList = dsc.dataServiceClass.getVocabList().map((unit, lectures) =>
      MapEntry(
          unit, lectures.keys.map((lecture) => [lecture, false]).toList()));

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

  //builds scrollable LectureList via ListView.builder
  Widget _buildLectureList(_unitList) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70.0),
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            _buildUnitName(_unitList[index]),
            Column(
                children: _lectureList[_unitList[index]]!
                    .map<Widget>((lecture) => CheckboxListTile(
                          value: lecture[1],
                          onChanged: (value) {
                            setState(() {
                              lecture[1] = value!;
                            });
                          },
                          title: Text(
                            lecture[0],
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
    );
  }

  //fills PracticeVocab in DataServiceClass and if its not empty then navigates to next page
  void confirmChoice() {
    final _practiceVocab = dsc.dataServiceClass.fillPracticeVocab(_lectureList);
    if (_practiceVocab == true) {
      Navigator.pushNamed(
        context,
        ChoosePracticeTypeScreen.routeName,
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
    final _chosenVocab = ModalRoute.of(context)!.settings.arguments.toString();
    if (dsc.dataServiceClass.getVocabList() == {} || _lectureList == {}) {
      dsc.dataServiceClass.fillVocabList(vocabRegister[_chosenVocab]![0]!);
      _lectureList = dsc.dataServiceClass.getVocabList().map((unit, lectures) =>
          MapEntry(
              unit, lectures.keys.map((lecture) => [lecture, false]).toList()));
    }
    final _unitList = _lectureList.keys.toList();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (dsc.dataServiceClass.getVocabList().isNotEmpty &&
                dsc.dataServiceClass.getCurrentVocab().isNotEmpty) {
              lds.localDataService
                  .writeToFile(json.encode(dsc.dataServiceClass.getVocabList()),
                      dsc.dataServiceClass.getCurrentVocab()[0])
                  .then((value) => Navigator.of(context).pop());
            }
          },
        ),
        title: const Text("Vyber lekci"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _buildLectureList(_unitList),
      floatingActionButton: FloatingActionButton(
        onPressed: confirmChoice,
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

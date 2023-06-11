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
  //map of units and lectures with switch to show chosen lectures
  Map _lectureList = dsc.dataServiceClass.getVocabList().map((unit, lectures) =>
      MapEntry(
          unit, lectures.keys.map((lecture) => [lecture, false]).toList()));
  //list of lists for chosen vocabulary [[unit, lecture, vocab]]
  final List _vocabularyList = [];
  bool value2 = true;

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

  //callback function to refresh page
  void _refresh(lectureVocab, lecture) {
    if (lectureVocab.any((e) => e[1] == true)) {
      setState(() {
        lecture[1] = true;
      });
    } else {
      setState(() {
        lecture[1] = false;
      });
    }
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
                            List _lectureVocab = dsc.dataServiceClass
                                .getLectureVocab(_unitList[index], lecture[0]);
                            for (var e in _lectureVocab) {
                              if (_vocabularyList.any((e2) => e2[2] == e[0])) {
                                e[1] = true;
                              }
                            }
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return AlertDialog(
                                        title: const Text('Vyber slovíčka'),
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: ListView(
                                              shrinkWrap: true,
                                              children: _lectureVocab
                                                  .map((e) => CheckboxListTile(
                                                      value: e[1],
                                                      onChanged: (val) {
                                                        setState(() {
                                                          e[1] = val!;
                                                        });
                                                      },
                                                      title: Text(e[0])))
                                                  .toList()),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              if (_lectureVocab
                                                  .any((e) => e[1] == false)) {
                                                for (var e2 in _lectureVocab) {
                                                  setState(() {
                                                    e2[1] = true;
                                                  });
                                                }
                                              } else {
                                                for (var e2 in _lectureVocab) {
                                                  setState(() {
                                                    e2[1] = false;
                                                  });
                                                }
                                              }
                                            },
                                            child: const Text('Vyber všechny'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              for (var e in _lectureVocab) {
                                                _vocabularyList.removeWhere(
                                                    (e2) => e2[2] == e[0]);
                                                if (e[1] == true) {
                                                  _vocabularyList.add([
                                                    _unitList[index],
                                                    lecture[0],
                                                    e[0]
                                                  ]);
                                                }
                                              }
                                              //callback function to refresh page
                                              _refresh(_lectureVocab, lecture);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    }));
                          },
                          title: Text(
                            lecture[0],
                            style: const TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        )) //-----------------
                    .toList()),
          ],
        );
      },
      itemCount: _lectureList.length,
    );
  }

  //fills PracticeVocab in DataServiceClass and if its not empty then navigates to next page
  void confirmChoice() {
    bool _practiceVocab =
        dsc.dataServiceClass.fillPracticeVocab2(_vocabularyList);
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
    //empty listview fix
    if (dsc.dataServiceClass.getVocabList() == {} || _lectureList == {}) {
      dsc.dataServiceClass.fillVocabList(
          vocabRegister[dsc.dataServiceClass.getCurrentVocab()]!);
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

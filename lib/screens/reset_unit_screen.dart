import 'package:flutter/material.dart';
import 'dart:convert';

import '../widgets/my_app_bar.dart';

import '../data/data_service_class.dart' as dsc;
import '../data/local_data_service.dart' as lds;

class ResetUnitScreen extends StatefulWidget {
  const ResetUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/reset-unit";

  @override
  State<ResetUnitScreen> createState() => _ResetUnitScreenState();
}

class _ResetUnitScreenState extends State<ResetUnitScreen> {
  //OLD CODE
  // final Map<String, List<List>> _lectureList1 = sixClassVocab.map((key, value) {
  //   return MapEntry(
  //       key,
  //       value.keys.map((e) {
  //         return [e, false];
  //       }).toList());
  // });

  //list of units and lectures + known word count
  final Map _lectureList =
      dsc.classService.getVocabList().map((unit, lectures) {
    return MapEntry(
        unit,
        lectures.keys.map((lecture) {
          int knownCount = 0;
          lectures[lecture].forEach((i) {
            if (i[2] == "learned") {
              knownCount++;
            }
          });
          return [
            lecture,
            false,
            " " +
                knownCount.toString() +
                "/" +
                lectures[lecture].length.toString()
          ];
        }).toList());
  });

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

  //builds scrollable Unit List via ListView.builder
  Widget _buildUnitList(_unitList) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70.0),
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            _buildUnitName(_unitList[index]),
            Column(
                children: _lectureList[_unitList[index]]
                    .map<Widget>((unit) => CheckboxListTile(
                          //NEEDS TO BE TOLD THAT WE MAP WIDGETS <Widget>
                          value: unit[1],
                          onChanged: (value) {
                            setState(() {
                              unit[1] = value!;
                            });
                          },
                          title: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  unit[0],
                                  style: const TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  unit[2],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 154, 154, 154),
                                  ),
                                ),
                              ],
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

  @override
  Widget build(BuildContext context) {
    final _unitList = _lectureList.keys.toList();

    return Scaffold(
      appBar: MyAppBar("Reset lekcí"),
      body: _buildUnitList(_unitList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //gose through selected and resets them
          _lectureList.forEach((key, value) {
            for (var lecture in value) {
              if (lecture[1] == true) {
                dsc.classService.resetLecture(key, lecture[0]);
              }
            }
          });
          //goes through VocabList and refreshes knownCount in _lectureList
          dsc.classService.getVocabList().forEach((unit, value) {
            int knownCount = 0;
            int lectureIndex = 0;
            value.keys.forEach((lecture) {
              value[lecture].forEach((i) {
                if (i[2] == "learned") {
                  knownCount++;
                }
              });
              _lectureList[unit][lectureIndex][2] = " " +
                  knownCount.toString() +
                  "/" +
                  value[lecture].length.toString();
              lectureIndex++;
            });
          });
          //saves changes to file and rebuilds page
          lds.localDataService
              .writeToFile(
                  json.encode(dsc.classService.getVocabList()), "sixClassVocab")
              .then((value) => setState(() {}));
        },
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

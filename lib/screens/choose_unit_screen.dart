import 'package:flutter/material.dart';

import './choose_practice_type.dart';
import '../widgets/my_app_bar.dart';
import '../data/vocabulary.dart';

class ChooseUnitScreen extends StatefulWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  State<ChooseUnitScreen> createState() => _ChooseUnitScreenState();
}

class _ChooseUnitScreenState extends State<ChooseUnitScreen> {
  final Map<String, List<List>> _lectureList = vocabulary.map((key, value) =>
      MapEntry(key, value.keys.map((e) => [e, false]).toList()));

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

  void confirmChoice() {
    final _practiceVocab = [];
    _lectureList.forEach((key, value) {
      for (var element in value) {
        if (element[1] == true) {
          _practiceVocab.addAll(vocabulary[key]![element[0]]!);
        }
      }
    });
    if (_practiceVocab.isNotEmpty) {
      Navigator.pushNamed(
        context,
        ChoosePracticeType.routeName,
        arguments: _practiceVocab,
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Vyber Lekci!'),
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
      appBar: MyAppBar("Vyber Lekce"),
      body: ListView.builder(
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
        itemCount: vocabulary.length,
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

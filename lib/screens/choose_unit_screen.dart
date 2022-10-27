import 'package:flutter/material.dart';
import 'package:procvicovani_app/screens/choose_practice_type.dart';

import '../widgets/my_app_bar.dart';
import '../data/vocabulary.dart';

class ChooseUnitScreen extends StatefulWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  State<ChooseUnitScreen> createState() => _ChooseUnitScreenState();
}

class _ChooseUnitScreenState extends State<ChooseUnitScreen> {
  final Map<String, List<List>> _unitList = vocabulary.map((key, value) =>
      MapEntry(key, value.keys.map((e) => [e, false]).toList()));

  @override
  Widget build(BuildContext context) {
    final unitList = _unitList.keys.toList();
    return Scaffold(
      appBar: MyAppBar("Vyber Lekce"),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              Text(unitList[index]),
              Column(
                  children: _unitList[unitList[index]]!
                      .map((unit) => CheckboxListTile(
                            value: unit[1],
                            onChanged: (value) {
                              setState(() {
                                unit[1] = value!;
                              });
                            },
                            title: Text(unit[0]),
                          ))
                      .toList()),
            ],
          );
        },
        itemCount: vocabulary.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final _practiceVocab = [];
          //projít celý _unit list a ty co jsou true uložit do listu.. poté nový screen ... upravit styl této stránky
          _unitList.forEach((key, value) {
            value.forEach((element) {
              if (element[1] == true) {
                _practiceVocab.addAll(vocabulary[key]![element[0]]!);
                print(_practiceVocab.length);
              }
            });
          });
          Navigator.pushNamed(context, ChoosePracticeType.routeName);
        },
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';
import '../widgets/default_checkbox.dart';

import '../data/vocabulary.dart';

class ChooseUnitScreen extends StatefulWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  State<ChooseUnitScreen> createState() => _ChooseUnitScreenState();
}

class _ChooseUnitScreenState extends State<ChooseUnitScreen> {
  final _unitList = vocabulary.keys.toList();

  late Map<String, Map<String, bool>> _lectionList;

  @override
  Widget build(BuildContext context) {
    vocabulary.forEach((key, value) {});

    return Scaffold(
      appBar: MyAppBar("Vyber Lekce"),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              Text(_unitList[index]),
              Column(
                  children: vocabulary[_unitList[index]]!
                      .keys
                      .map((unit) => CheckboxListTile(
                            value: false,
                            onChanged: (value) {
                              setState(() {});
                            },
                            title: Text(unit),
                          ))
                      .toList()),
            ],
          );
        },
        itemCount: vocabulary.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_lectionList);
        },
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

class Unit {
  String title;
  List lectures;
  List areChecked;

  Unit(this.title, this.lectures, this.areChecked);
}

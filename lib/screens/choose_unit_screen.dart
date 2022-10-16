import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';
import '../data/vocabulary.dart';

class ChooseUnitScreen extends StatefulWidget {
  const ChooseUnitScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-unit";

  @override
  State<ChooseUnitScreen> createState() => _ChooseUnitScreenState();
}

class _ChooseUnitScreenState extends State<ChooseUnitScreen> {
  final _unitList = vocabulary.keys.toList();
  final _switchList = List.generate(vocabulary.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Vyber Lekci"),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return CheckboxListTile(
            value: _switchList[index],
            onChanged: (value) {
              setState(() {
                _switchList[index] = value!;
              });
            },
            title: Text(_unitList[index]),
          );
        },
        itemCount: vocabulary.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.arrow_right_alt_sharp,
        ),
      ),
    );
  }
}

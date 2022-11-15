import 'package:flutter/material.dart';
import "dart:math";

import "../widgets/my_app_bar.dart";
import '../data/data_service_class.dart' as cs;

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({Key? key}) : super(key: key);
  static const routeName = "/flash-cards";

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  var _unknown = 0;
  var _learning = 0;
  var _learned = 0;

  Widget _buildCounter(text, counter) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      height: 35,
      child: VerticalDivider(
        width: 20,
        thickness: 1,
        color: Colors.grey.shade600,
      ),
    );
  }

  void _refreshCounters(practiceVocab) {
    _unknown = 0;
    _learning = 0;
    _learned = 0;
    for (var e in practiceVocab) {
      if (e[2] == "learned") {
        setState(() {
          _learned++;
        });
      } else if (e[2] == "learning") {
        setState(() {
          _learning++;
        });
      } else if (e[2] == "unknown") {
        setState(() {
          _unknown++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //set -> cs.classService, read -> _practiceVocab
    List _practiceVocab = cs.classService.getPracticeVocab();
    _refreshCounters(_practiceVocab);
    return Scaffold(
      appBar: MyAppBar(""),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCounter("Umím", _learned),
              _buildDivider(),
              _buildCounter("Znám", _learning),
              _buildDivider(),
              _buildCounter("Neumím", _unknown),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Random random = Random();
              cs.classService.setPracticeVocab(
                  _practiceVocab[random.nextInt(30)][0], "learned");
              _refreshCounters(_practiceVocab);
              print(_practiceVocab);
            },
            child: const Text("PRESS ME PLS"),
          ),
        ],
      ),
    );
  }
}

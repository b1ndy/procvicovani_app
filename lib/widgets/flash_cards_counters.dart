import 'package:flutter/material.dart';

import '../data/data_service_class.dart' as cs;

class FlashCardsCounters extends StatefulWidget {
  const FlashCardsCounters({Key? key}) : super(key: key);

  @override
  State<FlashCardsCounters> createState() => _FlashCardsCountersState();
}

class _FlashCardsCountersState extends State<FlashCardsCounters> {
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
    _refreshCounters(cs.classService.getPracticeVocab());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCounter("Neumím", _unknown),
        _buildDivider(),
        _buildCounter("Znám", _learning),
        _buildDivider(),
        _buildCounter("Umím", _learned),
      ],
    );
  }
}

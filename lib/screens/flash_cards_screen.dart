import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

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
  final List _practiceVocab = cs.classService.getPracticeVocab();

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
    _refreshCounters(
        _practiceVocab); // možná se refreshuje náhodně - zkusit init state
    List currentLexis = [_practiceVocab[0][0], _practiceVocab[0][1]];
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
          Container(
            height: 300,
            width: 300,
            child: Stack(
              children: [
                SwipableStack(
                  itemCount: 30,
                  builder: (context, properties) {
                    return FlipCard(
                      direction: FlipDirection.VERTICAL,
                      // front of the card
                      front: Container(
                        alignment: Alignment.center,
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 4,
                              offset: const Offset(3, 6), // Shadow position
                            ),
                          ],
                        ),
                        child: Text(_practiceVocab[properties.index][0]),
                      ),
                      // back of the card
                      back: Container(
                        alignment: Alignment.center,
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 4,
                              offset: const Offset(3, 6), // Shadow position
                            ),
                          ],
                        ),
                        child: Text(_practiceVocab[properties.index][1]),
                      ),
                    );
                  },
                  onSwipeCompleted: (index, direction) {
                    print('$index, $direction');
                  },
                  allowVerticalSwipe: false,
                  stackClipBehaviour: Clip.none,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

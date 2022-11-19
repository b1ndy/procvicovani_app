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
  List _practiceVocab = cs.classService.getPracticeVocab();
  final controller = SwipableStackController();
  final ValueNotifier<List<int>> _counterNotifier = ValueNotifier([0, 0, 0]);

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

  Widget _buildFlipContainer(text) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            blurRadius: 4,
            offset: const Offset(3, 6), // Shadow position
          ),
        ],
      ),
      child: Text(text),
    );
  }

  List<int> _refreshCounters(practiceVocab) {
    int _unknown = 0;
    int _learning = 0;
    int _learned = 0;
    for (var e in practiceVocab) {
      if (e[2] == "learned") {
        _learned++;
      } else if (e[2] == "learning") {
        _learning++;
      } else if (e[2] == "unknown") {
        _unknown++;
      }
    }
    return [_unknown, _learning, _learned];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(""),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _counterNotifier,
            builder: (context, List value, _) {
              value = _refreshCounters(_practiceVocab);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCounter("Neumím", value[0]),
                  _buildDivider(),
                  _buildCounter("Znám", value[1]),
                  _buildDivider(),
                  _buildCounter("Umím", value[2]),
                ],
              );
            },
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              children: [
                SwipableStack(
                  controller: controller,
                  itemCount: _practiceVocab.length,
                  builder: (context, properties) {
                    return FlipCard(
                      direction: FlipDirection.VERTICAL,
                      // front of the card
                      front: _buildFlipContainer(
                          _practiceVocab[properties.index][0]),
                      // back of the card
                      back: _buildFlipContainer(
                          _practiceVocab[properties.index][1]),
                    );
                  },
                  onSwipeCompleted: (index, direction) {
                    print('$index, $direction');
                    if (direction == SwipeDirection.right) {
                      if (_practiceVocab[index][2] == "unknown") {
                        cs.classService.setPracticeVocab(
                            _practiceVocab[index][0], "learning");
                      } else {
                        cs.classService.setPracticeVocab(
                            _practiceVocab[index][0], "learned");
                      }
                    }
                    if (direction == SwipeDirection.left) {
                      if (_practiceVocab[index][2] == "learned") {
                        cs.classService.setPracticeVocab(
                            _practiceVocab[index][0], "learning");
                      } else {
                        cs.classService.setPracticeVocab(
                            _practiceVocab[index][0], "unknown");
                      }
                    }

                    //nezařazovat ty co jsou LEARNED
                    print(_practiceVocab.length);
                    _counterNotifier.value = _refreshCounters(_practiceVocab);
                  },
                  allowVerticalSwipe: false,
                  stackClipBehaviour: Clip.none,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.currentIndex = 0;
            },
            child: Text("Restart"),
          )
        ],
      ),
    );
  }
}

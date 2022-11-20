//button to revind last swipe
//přepínač - procvičování čj-aj/aj-čj
import 'dart:math';

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
  Random randomGenerator = Random();
  List _practiceVocab = cs.classService.getPracticeVocab();
  final controller = SwipableStackController();
  //ValueNotifier if changed ValueListenableBuilder will refresh
  final ValueNotifier<List<int>> _counterNotifier =
      ValueNotifier(cs.classService.getCounters());

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

  //dec/inc _counterNotifier
  void _setCounter(dec, inc) {
    List<int> _counter = [
      _counterNotifier.value[0],
      _counterNotifier.value[1],
      _counterNotifier.value[2],
    ];

    switch (dec) {
      case "unknown":
        _counter[0]--;
        break;
      case "learning":
        _counter[1]--;
        break;
      case "learned":
        _counter[2]--;
        break;
      default:
    }
    switch (inc) {
      case "unknown":
        _counter[0]++;
        break;
      case "learning":
        _counter[1]++;
        break;
      case "learned":
        _counter[2]++;
        break;
      default:
    }

    _counterNotifier.value = [
      _counter[0],
      _counter[1],
      _counter[2],
    ].toList();
  }

  //on Swipe sets status of current lexis and refreshes counters
  void _handleSwipeDirection(direction, index) {
    if (direction == SwipeDirection.right) {
      if (_practiceVocab[index][2] == "unknown") {
        cs.classService.setPracticeVocab(_practiceVocab[index][0], "learning");
        _setCounter("unknown", "learning");
      } else if (_practiceVocab[index][2] == "learning") {
        cs.classService.setPracticeVocab(_practiceVocab[index][0], "learned");
        _setCounter("learning", "learned");
      }
    }
    if (direction == SwipeDirection.left) {
      if (_practiceVocab[index][2] == "learned") {
        cs.classService.setPracticeVocab(_practiceVocab[index][0], "learning");
        _setCounter("learned", "learning");
      } else if (_practiceVocab[index][2] == "learning") {
        cs.classService.setPracticeVocab(_practiceVocab[index][0], "unknown");
        _setCounter("learning", "unknown");
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.currentIndex = 0;
                    setState(() {
                      _practiceVocab = cs.classService.getPracticeVocab();
                    });
                  },
                  child: const Text("Continue"),
                ),
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
                    _handleSwipeDirection(direction, index);
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
              cs.classService.resetPracticeVocab();
              _counterNotifier.value = cs.classService.getCounters();
              setState(() {
                _practiceVocab = cs.classService.getPracticeVocab();
              });
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }
}

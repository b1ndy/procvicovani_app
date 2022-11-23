//napsat popis a návod flash cards
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../data/data_service_class.dart' as cs;

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({Key? key}) : super(key: key);
  static const routeName = "/flash-cards";

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  Random randomGenerator = Random();
  String _language = "Angličtina";
  bool _isSwitched = false;
  int _cardState1 = 0;
  int _cardState2 = 1;
  List _practiceVocab = cs.classService.getPracticeVocab();
  final controller = SwipableStackController();
  //ValueNotifier if changed ValueListenableBuilder will refresh
  final ValueNotifier<List<int>> _counterNotifier =
      ValueNotifier(cs.classService.getCounters());

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
              ),
              child: const Text(
                'Nastavení',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Přední strana: $_language"),
                Switch(
                  activeColor: Colors.grey.shade400,
                  activeTrackColor: Colors.grey.shade600,
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      if (_language == "Angličtina") {
                        _language = "Čeština";
                      } else {
                        _language = "Angličtina";
                      }
                      int _state = _cardState1;
                      _cardState1 = _cardState2;
                      _cardState2 = _state;
                    });
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_backup_restore,
            ),
            title: const Text("Restartovat"),
            onTap: () {
              controller.currentIndex = 0;
              cs.classService.resetPracticeVocab();
              _counterNotifier.value = cs.classService.getCounters();
              setState(() {
                _practiceVocab = cs.classService.getPracticeVocab();
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Potvrdit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildFlipContainer(text, height, width) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
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
    final appBar = AppBar(
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
      leading: const BackButton(),
      title: const Text(""),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    final _availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        84;
    final _availableWidth = MediaQuery.of(context).size.width;
    List _currentLexis = [];
    return Scaffold(
      appBar: appBar,
      endDrawer: _buildDrawer(),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _counterNotifier,
            builder: (context, List value, _) {
              return SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCounter("Neumím", value[0]),
                    _buildDivider(),
                    _buildCounter("Znám", value[1]),
                    _buildDivider(),
                    _buildCounter("Umím", value[2]),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: _availableHeight * 0.7,
            width: _availableWidth * 0.85,
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
                  child: const Text("Pokračovat"),
                ),
                SwipableStack(
                  controller: controller,
                  itemCount: _practiceVocab.length,
                  builder: (context, properties) {
                    return FlipCard(
                      direction: FlipDirection.VERTICAL,
                      // front of the card
                      front: _buildFlipContainer(
                        _practiceVocab[properties.index][_cardState1],
                        _availableHeight * 0.7,
                        _availableWidth * 0.85,
                      ),
                      // back of the card
                      back: _buildFlipContainer(
                        _practiceVocab[properties.index][_cardState2],
                        _availableHeight * 0.7,
                        _availableWidth * 0.85,
                      ),
                    );
                  },
                  onSwipeCompleted: (index, direction) {
                    print('$index, $direction');
                    _currentLexis = _practiceVocab[index].toList();
                    _handleSwipeDirection(direction, index);
                  },
                  allowVerticalSwipe: false,
                  stackClipBehaviour: Clip.none,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text("Zpět"),
          icon: const Icon(Icons.restart_alt),
          elevation: 2,
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.grey.shade300,
          onPressed: () {
            if (_currentLexis.isNotEmpty) {
              cs.classService
                  .setPracticeVocab(_currentLexis[0], _currentLexis[2]);
              controller.rewind();
              _counterNotifier.value = cs.classService.getCounters();
            }
          }),
    );
  }
}

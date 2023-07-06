import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../data/practice_toolbox.dart';
import '../data/data_service_class.dart' as dsc;
import '../data/instructions.dart';

class ChooseOneScreen extends StatefulWidget {
  const ChooseOneScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-one";

  @override
  State<ChooseOneScreen> createState() => _ChooseOneScreenState();
}

class _ChooseOneScreenState extends State<ChooseOneScreen> {
  var rng = Random();
  String _language = "Angličtina";
  bool _isSwitched = false;
  int _vocabIndex = 0;
  int _correct = 0;
  int _incorrect = 0;
  //[jednotky[lekce[slovíčka]]]
  final List _vocabList = dsc.dataServiceClass.getVocabList().values.map((e) {
    return e.values.map((e2) {
      return e2.map((e3) {
        return e3;
      }).toList();
    }).toList();
  }).toList();
  List _practiceVocab = dsc.dataServiceClass.getAllPracticeVocab();
  List _failedVocab = [];
  //setting default
  final ValueNotifier<BoxDecoration> _textBoxDecoration =
      ValueNotifier(textBoxDefault);
  final ValueNotifier<bool> _isDisabled = ValueNotifier(false);

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
                Text("Zadané slovo: $_language"),
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
              setState(() {
                _correct = 0;
                _incorrect = 0;
                _vocabIndex = 0;
                _practiceVocab = dsc.dataServiceClass.getAllPracticeVocab();
                _failedVocab = [];
                _isDisabled.value = false;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
            ),
            title: const Text("Návod"),
            onTap: () {
              Navigator.pop(context);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Návod"),
                  content: const Text(chooseOneGuide),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
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

  Widget _buildButton(text) {
    return ValueListenableBuilder(
        valueListenable: _isDisabled,
        builder: (context, bool value, _) {
          return Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0,
                  0.25,
                  0.5,
                  0.75,
                  1,
                ],
                colors: [
                  Color.fromARGB(255, 116, 116, 116),
                  Color.fromARGB(255, 82, 82, 82),
                  Color.fromARGB(255, 66, 66, 66),
                  Color.fromARGB(255, 82, 82, 82),
                  Color.fromARGB(255, 116, 116, 116),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text),
              ),
              onPressed: value == true
                  ? null
                  : () {
                      _isDisabled.value = true;
                      if (text ==
                          _practiceVocab[_vocabIndex]
                              [_language == "Angličtina" ? 1 : 0]) {
                        _correct++;
                        _textBoxDecoration.value = textBoxGreen;
                      } else {
                        _incorrect++;
                        _textBoxDecoration.value = textBoxRed;
                        _failedVocab.add(_practiceVocab[_vocabIndex]);
                      }
                      Timer(const Duration(milliseconds: 300), () {
                        if (_vocabIndex + 1 != _practiceVocab.length) {
                          _textBoxDecoration.value = textBoxDefault;
                          _isDisabled.value = false;
                          setState(() {
                            _vocabIndex++;
                          });
                        } else {
                          _textBoxDecoration.value = textBoxDefault;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Skvělá práce!"),
                              content: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: 'Měl jsi '),
                                    TextSpan(
                                      text: _correct.toString(),
                                      style: const TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const TextSpan(
                                        text: ' slovíčka správně a '),
                                    TextSpan(
                                      text: _incorrect.toString(),
                                      style: const TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const TextSpan(text: ' špatně.'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _correct = 0;
                                      _incorrect = 0;
                                      _vocabIndex = 0;
                                      _practiceVocab = dsc.dataServiceClass
                                          .getAllPracticeVocab();
                                      _failedVocab = [];
                                      _isDisabled.value = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Restart'),
                                ),
                                if (_failedVocab.isNotEmpty)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _correct = 0;
                                        _incorrect = 0;
                                        _vocabIndex = 0;
                                        _practiceVocab = _failedVocab;
                                        _failedVocab = [];
                                        _isDisabled.value = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Pokračovat'),
                                  ),
                              ],
                            ),
                          );
                        }
                      });
                    },
            ),
          );
        });
  }

  _buildButtonSection(text1, text2, text3, text4, height) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          _buildButton(text1),
          _buildButton(text2),
          _buildButton(text3),
          _buildButton(text4),
        ],
      ),
    );
  }

  void _findButtonTexts(List _buttonTexts) {
    //creates list of shuffeled numbers of units - to avoid repetition
    List _unitCounter = [];
    for (var i = 0; i < _vocabList.length; i++) {
      _unitCounter.add(i);
    }
    _unitCounter.shuffle();
    //if total number of words in current phrase is 3 and more, then any phrase with more than two words is accepted
    if (_practiceVocab[_vocabIndex][_language == "Angličtina" ? 1 : 0]
            .split(" ")
            .length >
        2) {
      for (var i = 0; i < 3; i++) {
        //goes through all units, picks random lecture
        unitLoop:
        for (var _unit in _unitCounter) {
          int _lecture = rng.nextInt(_vocabList[_unit].length);
          for (var _vocab in _vocabList[_unit][_lecture]) {
            if ((_vocab[_language == "Angličtina" ? 1 : 0].split(" ").length >
                    2) &&
                !_buttonTexts
                    .contains(_vocab[_language == "Angličtina" ? 1 : 0])) {
              _buttonTexts.add(_vocab[_language == "Angličtina" ? 1 : 0]);
              break unitLoop;
            }
          }
        }
      }
    } else {
      //if total number of words is less than 3, then only phrase with precisely same number of words is accepted
      for (var i = 0; i < 3; i++) {
        unitLoop:
        for (var _unit in _unitCounter) {
          int _lecture = rng.nextInt(_vocabList[_unit].length);
          for (var _vocab in _vocabList[_unit][_lecture]) {
            if ((_practiceVocab[_vocabIndex][_language == "Angličtina" ? 1 : 0]
                        .split(" ")
                        .length ==
                    _vocab[_language == "Angličtina" ? 1 : 0]
                        .split(" ")
                        .length) &&
                !_buttonTexts
                    .contains(_vocab[_language == "Angličtina" ? 1 : 0])) {
              _buttonTexts.add(_vocab[_language == "Angličtina" ? 1 : 0]);
              break unitLoop;
            }
          }
        }
      }
    }
    //adds empty strings to total of 4
    if (_buttonTexts.length < 4) {
      int rep = 4 - _buttonTexts.length;
      for (int i = 0; i < rep; i++) {
        _buttonTexts.add("");
      }
    }
    _buttonTexts.shuffle();
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

    //list of phrases for buttons - with the correct one in
    List _buttonTexts = [
      _practiceVocab[_vocabIndex][_language == "Angličtina" ? 1 : 0]
    ];
    _findButtonTexts(_buttonTexts);

    return Scaffold(
      appBar: appBar,
      endDrawer: _buildDrawer(),
      body: Column(
        children: [
          buildCounter(_availableHeight, _vocabIndex, _practiceVocab),
          buildTextBox(
            _practiceVocab[_vocabIndex][_language == "Angličtina" ? 0 : 1],
            _availableHeight,
            _textBoxDecoration,
          ),
          _buildButtonSection(
            _buttonTexts[0],
            _buttonTexts[1],
            _buttonTexts[2],
            _buttonTexts[3],
            _availableHeight,
          ),
        ],
      ),
    );
  }
}

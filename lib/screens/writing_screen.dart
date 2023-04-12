import 'dart:async';
import 'package:flutter/material.dart';

import '../data/practice_toolbox.dart';
import '../data/data_service_class.dart' as dsc;
import '../data/instructions.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({Key? key}) : super(key: key);
  static const routeName = "/writing";

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  String _language = "Angličtina";
  bool _isSwitched = false;
  int _vocabIndex = 0;
  int _correct = 0;
  int _incorrect = 0;
  final TextEditingController _vocabController = TextEditingController();
  List _practiceVocab = dsc.dataServiceClass.getAllPracticeVocab();
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
                _practiceVocab = dsc.dataServiceClass.getPracticeVocab();
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
                  content: const Text(""),
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

  void _handleVocabSub() {
    _isDisabled.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    if (_vocabController.text ==
        _practiceVocab[_vocabIndex][_language == "Angličtina" ? 1 : 0]) {
      _correct++;
      _textBoxDecoration.value = textBoxGreen;
    } else {
      _incorrect++;
      _textBoxDecoration.value = textBoxRed;
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
                  const TextSpan(text: ' slovíčka správně a '),
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
                    _practiceVocab = dsc.dataServiceClass.getPracticeVocab();
                    _isDisabled.value = false;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Restart'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _vocabController.dispose();
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar,
        endDrawer: _buildDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildCounter(_availableHeight, _vocabIndex, _practiceVocab),
              buildTextBox(
                _practiceVocab[_vocabIndex][_language == "Angličtina" ? 0 : 1],
                _availableHeight,
                _textBoxDecoration,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (_correct + _incorrect) == _practiceVocab.length
                      ? null
                      : (_) => _handleVocabSub(),
                  controller: _vocabController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: 'Enter Czech Translation',
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
            valueListenable: _isDisabled,
            builder: (context, bool value, _) {
              return FloatingActionButton(
                onPressed: value == true
                    ? null
                    : () {
                        _handleVocabSub();
                      },
                child: const Icon(
                  Icons.chevron_right_rounded,
                ),
              );
            }),
      ),
    );
  }
}

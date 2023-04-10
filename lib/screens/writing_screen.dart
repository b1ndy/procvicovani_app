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
  TextEditingController _vocabController = TextEditingController();
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
    final List _wordList = _practiceVocab
        .map((e) => e[_language == "Angličtina" ? 1 : 0])
        .toList();
    List _buttonTexts = [_wordList[_vocabIndex]];
    _wordList.removeAt(_vocabIndex);
    for (int i = 0; i < 3; i++) {
      if (_wordList.isEmpty) {
        break;
      }
      _wordList.shuffle();
      _buttonTexts.add(_wordList[0]);
      _wordList.removeAt(0);
    }
    if (_buttonTexts.length < 4) {
      int rep = 4 - _buttonTexts.length;
      for (int i = 0; i < rep; i++) {
        _buttonTexts.add("");
      }
    }
    _buttonTexts.shuffle();

    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.chevron_right_rounded,
        ),
      ),
    );
  }
}

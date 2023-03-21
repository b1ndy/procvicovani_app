import 'package:flutter/material.dart';

import '../data/data_service_class.dart' as cs;
import '../data/instructions.dart';

class ChooseOneScreen extends StatefulWidget {
  const ChooseOneScreen({Key? key}) : super(key: key);
  static const routeName = "/choose-one";

  @override
  State<ChooseOneScreen> createState() => _ChooseOneScreenState();
}

class _ChooseOneScreenState extends State<ChooseOneScreen> {
  final String _language = "Angličtina";
  bool _isSwitched = false;
  final List _practiceVocab = cs.classService.getPracticeVocab();

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

  Widget _buildCounter(height) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      alignment: Alignment.bottomCenter,
      height: height * 0.1,
      child: const Text(
        "4/6",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTextBox(text, height) {
    return Container(
      height: height * 0.3,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1.2,
            color: Color.fromRGBO(171, 171, 171, 1),
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0,
            0.15,
            0.5,
            0.85,
            1,
          ],
          colors: [
            Color.fromARGB(255, 70, 70, 70),
            Color.fromARGB(255, 49, 49, 49),
            Color.fromARGB(255, 39, 39, 39),
            Color.fromARGB(255, 49, 49, 49),
            Color.fromARGB(255, 70, 70, 70),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _buildButton(text) {
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
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text),
        ),
        onPressed: () {},
      ),
    );
  }

  _buildButtonSection(text1, text2, text3, text4, height) {
    return Container(
      height: height * 0.6,
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
    return Scaffold(
      appBar: appBar,
      endDrawer: _buildDrawer(),
      body: Column(
        children: [
          _buildCounter(_availableHeight),
          _buildTextBox(
            "plane",
            _availableHeight,
          ),
          _buildButtonSection(
            "A:....",
            "B:....",
            "C:....",
            "D:....",
            _availableHeight,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text("Zpět"),
          icon: const Icon(Icons.restart_alt),
          elevation: 2,
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.grey.shade300,
          onPressed: () {}),
    );
  }
}

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
  // ignore: unused_field
  final List _practiceVocab = cs.dataServiceClass.getPracticeVocab();

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
          SizedBox(
            height: _availableHeight * 0.7,
            width: _availableWidth * 0.85,
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

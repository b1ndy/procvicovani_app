import 'dart:convert';
import 'package:flutter/material.dart';

import './choose_class_screen.dart';
import './settings_screen.dart';

import '../widgets/default_button.dart';
import '../widgets/my_app_bar.dart';
import "../widgets/inf_button.dart";

import '../data/instructions.dart';
import '../data/vocab_register.dart';
import '../data/data_service_class.dart' as dsc;
import '../data/local_data_service.dart' as lds;

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //if file exists, nothing happens, if file doesn't exists it is created
    vocabRegister.forEach((k, v) {
      lds.localDataService.localFile(k[0]).then((value) {
        if (!value.existsSync()) {
          lds.localDataService.writeToFile(json.encode(v), k[0]);
        }
      });
    });

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  //when background (eg closing app) save progress
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      if (dsc.dataServiceClass.getCurrentVocab().isNotEmpty &&
          dsc.dataServiceClass.getVocabList().isNotEmpty) {
        lds.localDataService.writeToFile(
            json.encode(dsc.dataServiceClass.getVocabList()),
            dsc.dataServiceClass.getCurrentVocab()[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(""),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/img/gb_flag.jpg",
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                ),
                Column(
                  children: const [
                    Text(
                      "Procvičování slovní zásoby",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "učebnice Project Explore 1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            const DefaultButton(
              "Začít procvičovat",
              ChooseClassScreen.routeName,
            ),
            const DefaultButton(
              "Resetovat postup",
              SettingsScreen.routeName,
            ),
            const InfButton("Nápověda", "Nápověda k aplikaci", helpText),
            const InfButton("O aplikaci", "O aplikaci", aboutAppText),
          ],
        ),
      ),
    );
  }
}

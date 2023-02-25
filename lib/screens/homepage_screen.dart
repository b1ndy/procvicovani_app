import 'package:flutter/material.dart';

import './choose_class_screen.dart';
import './settings_screen.dart';

import '../widgets/default_button.dart';
import '../widgets/my_app_bar.dart';
import "../widgets/inf_button.dart";

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({Key? key}) : super(key: key);

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
              "Nastavení",
              SettingsScreen.routeName,
            ),
            const InfButton("O aplikaci"),
          ],
        ),
      ),
    );
  }
}

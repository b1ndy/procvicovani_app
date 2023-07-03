import 'package:flutter/material.dart';

//textBox default value
const BoxDecoration textBoxDefault = BoxDecoration(
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
);

//textBox red
const BoxDecoration textBoxRed = BoxDecoration(
  border: Border.symmetric(
    horizontal: BorderSide(
      width: 1.2,
      color: Color.fromRGBO(171, 171, 171, 1),
    ),
  ),
  color: Colors.red,
);

//textBox green
const BoxDecoration textBoxGreen = BoxDecoration(
  border: Border.symmetric(
    horizontal: BorderSide(
      width: 1.2,
      color: Color.fromRGBO(171, 171, 171, 1),
    ),
  ),
  color: Colors.green,
);

Widget buildCounter(height, vocabIndex, practiceVocab) {
  return Container(
    padding: const EdgeInsets.only(
      bottom: 10,
    ),
    alignment: Alignment.bottomCenter,
    height: height * 0.1,
    child: Text(
      (vocabIndex + 1).toString() + "/" + (practiceVocab.length).toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
  );
}

Widget buildTextBox(text, height, valueListenable) {
  return ValueListenableBuilder(
    valueListenable: valueListenable,
    builder: (context, BoxDecoration value, _) {
      return Container(
        height: height * 0.3,
        width: double.infinity,
        decoration: value,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

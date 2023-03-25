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

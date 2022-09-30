import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  final String titleText;

  MyAppBar(this.titleText, {Key? key})
      : super(
          key: key,
          title: Text(titleText),
          elevation: 0,
          backgroundColor: Colors.transparent,
        );
}

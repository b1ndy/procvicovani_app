import 'package:flutter/material.dart';
import 'package:procvicovani_app/widgets/my_app_bar.dart';

class ChoosePracticeType extends StatelessWidget {
  const ChoosePracticeType({Key? key}) : super(key: key);
  static const routeName = "/choose-practice";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("xxx"),
    );
  }
}

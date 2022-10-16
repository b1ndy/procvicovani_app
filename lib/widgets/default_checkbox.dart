import 'package:flutter/material.dart';

class DefaultCheckbox extends StatefulWidget {
  final String title;
  const DefaultCheckbox({
    Key? key,
    this.title = "",
  }) : super(key: key);

  @override
  State<DefaultCheckbox> createState() => _DefaultCheckboxState();
}

class _DefaultCheckboxState extends State<DefaultCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
      title: Text(widget.title),
    );
  }
}

import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final String route;

  // ignore: use_key_in_widget_constructors
  const DefaultButton(
    this.text,
    this.route,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: ElevatedButton(
        child: Text(text),
        onPressed: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}

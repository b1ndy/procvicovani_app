import 'package:flutter/material.dart';

class InfButton extends StatelessWidget {
  final String text;

  // ignore: use_key_in_widget_constructors
  const InfButton(this.text);

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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('O aplikaci'),
            content: const Text('bla bla bla'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

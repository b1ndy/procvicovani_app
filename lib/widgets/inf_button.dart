import 'package:flutter/material.dart';

class InfButton extends StatelessWidget {
  final String buttonText;
  final String headlineText;
  final String alertText;

  // ignore: use_key_in_widget_constructors
  const InfButton(this.buttonText, this.headlineText, this.alertText);

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
        child: Text(buttonText),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(headlineText),
            content: Text(alertText),
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

import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final String routeName;
  final String infoText;
  final List arg;

  // ignore: use_key_in_widget_constructors
  const ButtonWithIcon(this.text, this.routeName, this.infoText, this.arg);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(text),
                  content: Text(infoText),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onPressed: () =>
            Navigator.pushNamed(context, routeName, arguments: arg),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({Key? key}) : super(key: key);
  static const routeName = "/flash-cards";

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  final _unknown = 0;
  final _learning = 0;
  final _learned = 0;

  Widget _buildCounter(text, counter) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildVDivider() {
    return SizedBox(
      height: 35,
      child: VerticalDivider(
        width: 20,
        thickness: 1,
        color: Colors.grey.shade600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _practiceVocab = ModalRoute.of(context)!.settings.arguments as List;
    print(_practiceVocab);
    return Scaffold(
      appBar: MyAppBar(""),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCounter("Umím", _learned),
              _buildVDivider(),
              _buildCounter("Znám", _learning),
              _buildVDivider(),
              _buildCounter("Neumím", _unknown),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const CalculatorButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            onTap(text);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 23, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
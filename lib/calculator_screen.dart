import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'calculator_button.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String resText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 178, 227, 185),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/calculator.svg',
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Calculator',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    resText,
                    style: const TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(text: 'sq', onTap: onOperatorClicked),
                CalculatorButton(text: '%', onTap: onOperatorClicked),
                CalculatorButton(text: 'c', onTap: onClearClick),
                CalculatorButton(text: 'x', onTap: onDeleteClick),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(text: 'cos', onTap: onOperatorClicked),
                CalculatorButton(text: 'sin', onTap: onOperatorClicked),
                CalculatorButton(text: 'tan', onTap: onOperatorClicked),
                CalculatorButton(text: 'x!', onTap: onOperatorClicked),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: '7',
                  onTap: (text) {},
                ),
                CalculatorButton(text: '8', onTap: onDigitClick),
                CalculatorButton(text: '9', onTap: onDigitClick),
                CalculatorButton(text: '/', onTap: onOperatorClicked),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(text: '4', onTap: onDigitClick),
                CalculatorButton(text: '5', onTap: onDigitClick),
                CalculatorButton(text: '6', onTap: onDigitClick),
                CalculatorButton(text: '*', onTap: onOperatorClicked),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(text: '1', onTap: onDigitClick),
                CalculatorButton(text: '2', onTap: onDigitClick),
                CalculatorButton(text: '3', onTap: onDigitClick),
                CalculatorButton(text: '-', onTap: onOperatorClicked),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(text: '.', onTap: onDigitClick),
                CalculatorButton(text: '0', onTap: onDigitClick),
                CalculatorButton(text: '=', onTap: onEqualClick),
                CalculatorButton(text: '+', onTap: onOperatorClicked),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onClearClick(String text) {
    setState(() {
      resText = '';
    });
  }

  void onDeleteClick(String text) {
    setState(() {
      if (resText.isNotEmpty) {
        resText = resText.substring(0, resText.length - 1);
      }
    });
  }

  void onDigitClick(String text) {
    setState(() {
      resText += text;
    });
  }

  String lhs = '';
  String operator = '';

  void onOperatorClicked(String clickOperator) {
    setState(() {
      if (operator.isEmpty) {
        lhs = resText;
      } else {
        String rhs = resText;
        lhs = calculate(lhs, operator, rhs);
      }
      operator = clickOperator;
      resText = '';
      setState(() {});
    });
  }

  void onEqualClick(String text) {
    String rhs = resText;
    resText = calculate(lhs, operator, rhs);
    lhs = '';
    operator = '';
    setState(() {});
  }

  String calculate(String lhs, String operator, String rhs) {
    double num1 = double.parse(lhs);
    double num2 = double.parse(rhs);
    double res = 0;

    if (operator == '+') {
      res = num1 + num2;
    } else if (operator == '-') {
      res = num1 - num2;
    } else if (operator == '*') {
      res = num1 * num2;
    } else if (operator == '/') {
      if (num2 != 0) {
        res = num1 / num2;
      } else {
        return 'Cant Division by zero';
      }
    } else if (operator == '%') {
      if (num2 != 0) {
        res = num1 % num2;
      } else {
        return 'Cant Modulus by zero';
      }
    } else if (operator == 'sq') {
      if (num1 >= 0) {
        res = sqrt(num1);
      } else {
        return 'Error: Cannot calculate square root of a negative number';
      }
    } else if (operator == 'cos') {
      res = cos(num1);
    } else if (operator == 'sin') {
      res = sin(num1);
    } else if (operator == 'tan') {
      res = tan(num1);
    } else if (operator == 'x!') {
      res = factorial(num1.toInt());
    } else {
      return 'Error: Invalid operator';
    }

    return res.toString();
  }
}

double factorial(int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}

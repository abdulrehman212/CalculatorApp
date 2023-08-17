import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNUM = 0.0;
  double secondNUM = 0.0;

  var input = '';
  var output = '';
  var operator = '';

  var hideInput = false;
  var outputSize = 32.0;

  onClick(String value) {
    if (value == "AC"
        // ||
        //     (input.startsWith("+") && input.isNotEmpty) ||
        //     (input.startsWith("-") && input.isNotEmpty) ||
        //     (input.startsWith("-") && input.isNotEmpty) ||
        //     (input.startsWith("X") && input.isNotEmpty) ||
        //     (input.startsWith("/") && input.isNotEmpty) ||
        //     (input.startsWith("%") && input.isNotEmpty)
        ) {
      input = '';
      output = '';
    } else if (value == "Del") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        userInput = userInput.replaceAll("π", "pi");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 32;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: operatorColor,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  tColor: orangeColor,
                  buttonBGColor: operatorColor),
              button(
                  text: "Del",
                  tColor: orangeColor,
                  buttonBGColor: operatorColor),
              button(
                  text: "%", tColor: orangeColor, buttonBGColor: operatorColor),
              button(
                  text: "/", tColor: orangeColor, buttonBGColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "7",
              ),
              button(
                text: "8",
              ),
              button(
                text: "9",
              ),
              button(
                  text: "x", tColor: orangeColor, buttonBGColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "4",
              ),
              button(
                text: "5",
              ),
              button(
                text: "6",
              ),
              button(
                  text: "-", tColor: orangeColor, buttonBGColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "3",
              ),
              button(
                text: "2",
              ),
              button(
                text: "1",
              ),
              button(
                  text: "+", tColor: orangeColor, buttonBGColor: operatorColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(22),
                            backgroundColor: buttonColor),
                        onPressed: () => onClick("0"),
                        child: const Text(
                          "0",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w200),
                        ))),
              ),
              button(
                text: ".",
              ),
              button(
                  text: "=", tColor: Colors.black, buttonBGColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBGColor = buttonColor}) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(22),
                  backgroundColor: buttonBGColor),
              onPressed: () => onClick(text),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 24, color: tColor, fontWeight: FontWeight.w200),
              ))),
    );
  }
}

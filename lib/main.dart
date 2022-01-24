import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/calc_btn.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = "";
  String _history = "";
  bool _completed = false;

  void numClick(String text) {
    setState(() {
      if (_completed) {
        _expression = "";
        _completed = false;
      }
      _expression += text;
    });
  }

  void opClick(String text) {
    setState(() {
      if (_completed) {
        _completed = false;
      }
      if (text != "x") {
        _expression += text;
      } else {
        _expression += "*";
      }
    });
  }

  void allClearClick(String text) {
    setState(() {
      _expression = "";
      _history = "";
    });
  }

  void clearClick(String text) {
    setState(() {
      _expression = "";
    });
  }

  void evaluate(String text) {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        _history = _expression;
        _expression =
            eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 2);
        //var format = 
        _completed = true;
      } on Exception catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please correct your expression"),
          duration: Duration(milliseconds: 2750),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: const Alignment(1, 1),
                padding: const EdgeInsets.all(10),
                color: Colors.teal,
                child: Text(
                  _history,
                  style: const TextStyle(color: Color(0xFFE0F2F1), fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: const Alignment(1, 1),
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                padding: const EdgeInsets.all(10),
                color: Colors.teal,
                child: Text(
                  _expression,
                  style:
                      const TextStyle(color: Colors.tealAccent, fontSize: 48),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: CharacterButton(
                  text: "AC",
                  callback: allClearClick,
                )),
                Expanded(
                    child: CharacterButton(text: "C", callback: clearClick)),
                Expanded(child: CharacterButton(text: "%", callback: numClick)),
                Expanded(child: CharacterButton(text: "/", callback: opClick)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: NumericButton(
                  text: "7",
                  callback: numClick,
                )),
                Expanded(
                    child: NumericButton(
                  text: "8",
                  callback: numClick,
                )),
                Expanded(
                    child: NumericButton(
                  text: "9",
                  callback: numClick,
                )),
                Expanded(child: CharacterButton(text: "x", callback: opClick)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: NumericButton(
                  text: "4",
                  callback: numClick,
                )),
                Expanded(child: NumericButton(text: "5", callback: numClick)),
                Expanded(child: NumericButton(text: "6", callback: numClick)),
                Expanded(child: CharacterButton(text: "-", callback: opClick)),
              ],
            ),
            Row(
              children: [
                Expanded(child: NumericButton(text: "1", callback: numClick)),
                Expanded(child: NumericButton(text: "2", callback: numClick)),
                Expanded(child: NumericButton(text: "3", callback: numClick)),
                Expanded(child: CharacterButton(text: "+", callback: opClick)),
              ],
            ),
            Row(
              children: [
                Expanded(child: NumericButton(text: ".", callback: numClick)),
                Expanded(child: NumericButton(text: "0", callback: numClick)),
                Expanded(child: NumericButton(text: "00", callback: numClick)),
                Expanded(child: CharacterButton(text: "=", callback: evaluate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

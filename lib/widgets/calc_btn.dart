import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumericButton extends StatefulWidget {
  final String text;
  final Function callback;

  const NumericButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  _NumericButtonState createState() => _NumericButtonState(text, callback);
}

class _NumericButtonState extends State<NumericButton> {
  String text;
  final Function callback;

  _NumericButtonState(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 65,
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          callback(text);
        },
        child: Text(
          text,
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(
              color: Colors.tealAccent,
              fontSize: 20,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}

class CharacterButton extends StatefulWidget {
  final String text;
  final Function callback;

  const CharacterButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterButtonState(text, callback);
}

class _CharacterButtonState extends State<CharacterButton> {
  String text;
  Function callback;

  _CharacterButtonState(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 65,
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          callback(text);
        },
        child: Text(
          text,
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(
              color: Colors.teal,
              fontSize: 20,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), primary: Colors.tealAccent),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RoundedEditText extends StatefulWidget {
  final String hint;

  RoundedEditText({required this.hint});

  @override
  _RoundedEditTextState createState() => _RoundedEditTextState();
}

class _RoundedEditTextState extends State<RoundedEditText> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String getEnteredText() {
    return _textController.text;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginInput extends StatefulWidget {
  LoginInput({Key key, this.text, this.fx}) : super(key: key);
  final String text;
  final Function fx;
  String value;

  @override
  _LoginInput createState() => _LoginInput();
}

class _LoginInput extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: Colors.transparent,
      child: TextField(
        decoration: new InputDecoration(
          focusColor: Color.fromRGBO(0, 200, 120, .5),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          filled: true,
          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: widget.text,
        ),
        onChanged: (txt) {
          this.widget.value = txt;
        },
      ),
    ));
  }
}

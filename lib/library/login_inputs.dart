import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginInput extends StatefulWidget {
  LoginInput({Key key, this.text, this.fx, this.value}) : super(key: key);
  final String text;
  final Function fx;

  TextEditingController value;

  @override
  _LoginInput createState() => _LoginInput();
}

class _LoginInput extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.transparent,
          child: TextField(
            controller: widget.value,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              hintText: widget.text,
            )      
          ),
        ));
  }
}

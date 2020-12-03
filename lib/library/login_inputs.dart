import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LoginInput extends StatefulWidget {
  LoginInput({Key key, this.text, this.fx, this.value, this.password, this.length,this.mask}) : super(key: key);
  final String text;
  final Function fx;
  bool password = false;
  final int length;
  TextEditingController value;
  List<TextInputFormatter> mask;
  
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
            inputFormatters: widget.mask,
            controller: widget.value,
            textAlign: TextAlign.center,
            maxLength: widget.length,
            obscureText: this.widget.password,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              hintStyle: new TextStyle(color: Color.fromRGBO(0, 0, 0, .3)),
              hintText: widget.text,
            )      
          ),
        ));
  }
}

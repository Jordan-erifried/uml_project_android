import 'package:flutter/material.dart';
import 'package:uml_project_android/widgets/connexion_page.dart';

class MyTextField extends StatefulWidget {
  final controller;
  final bool obscureText;
  String titre;
  TypeTextField type;
  TextInputType inputType;

  MyTextField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.titre,
    required this.type,
    required this.inputType,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late String username = '';
  late String password;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.titre,
          hintStyle: TextStyle(
            color: Colors.grey[500]
          )
        ),
        onChanged: (value) async{
          switch (widget.type) {
            case TypeTextField.email:
              username = value;
              break;
            case TypeTextField.password:
              password = value;
              break;
          }
        },
      ),
    );
  }
}

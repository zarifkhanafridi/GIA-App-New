import 'package:flutter/material.dart';

import '../util/constants.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final int? maxNumber;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? myController;
  final Icon? icon;
  const MyTextField(
      {Key? key,
      this.maxNumber,
      this.label,
      this.maxLines,
      this.myController,
      this.icon,
      this.minLines})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      cursorColor: kPrimaryColor,
      controller: widget.myController,
      maxLines: widget.maxLines,
      maxLength: widget.maxNumber,

      //minLines: widget.minLines,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill the Field';
        } else if (value == ',' || value == '.' || value == "_") {
          return "Invalid Entry: &, @ , . '_' ";
        } else if (value == ' ') {
          return 'Empty space not allowed';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontWeight: FontWeight.w500),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.icon == null ? null : widget.icon,
        labelText: widget.label,
        labelStyle: TextStyle(
            fontSize: size.width > 600 ? size.width * 0.02 : size.width * 0.040,

            // fontSize: size.width * 0.035,

            color: Colors.black),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

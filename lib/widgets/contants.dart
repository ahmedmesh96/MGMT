import 'package:flutter/material.dart';

const decorationTextfield = InputDecoration(
  fillColor: Color.fromRGBO(255, 255, 255, 1),
  // To delete borders
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 253, 164, 0),
    ),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: EdgeInsets.all(8),
);
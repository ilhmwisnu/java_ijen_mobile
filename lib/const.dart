import 'package:flutter/material.dart';

InputDecoration formStyle = InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    prefixIconColor: Colors.grey,
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9999)));

List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.3),
    blurRadius: 20,
  ),
];

const double defaultPadding = 16;

Color darkGrey = Color(0xff282C2F);
Color darkChoco = Color(0xff6A462F);

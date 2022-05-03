import 'package:flutter/material.dart';

InputDecoration formStyle = InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    prefixIconColor: Colors.grey,
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9999)));

List<BoxShadow> shadow = [
  BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 30,
      offset: Offset(0, 3)),
];

const double defaultPadding = 16;

const Color darkGrey = Color(0xff282C2F);
const Color darkChoco = Color(0xff6A462F);
const Color green = Color(0xff7CB342);

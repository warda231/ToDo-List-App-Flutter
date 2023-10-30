import 'package:flutter/material.dart';

Widget button({onPress, text, color, textColor}) {
  return Padding(
    padding: const EdgeInsets.only(bottom:10),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.all(4),
          minimumSize: Size(150, 50),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )),
  );
}
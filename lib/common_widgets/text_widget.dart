import 'package:flutter/material.dart';

Widget txtWidget({ val,controller,color,txt,icon,validator}){
  return TextFormField(
    obscureText: val,
    controller: controller,
    decoration: InputDecoration(
      fillColor: color,
      hintText: txt,
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      border: InputBorder.none,
      filled: true,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    validator: validator,
  );

}
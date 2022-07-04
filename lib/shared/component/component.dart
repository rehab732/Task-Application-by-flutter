import 'package:flutter/material.dart';

Widget formfieldd({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String labelText,
  required IconData prefix,
  required bool ispass,
  required Function onTap,
   bool isclick=false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispass,
      validator: validate(),
      onTap: onTap(),
      expands: isclick,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: labelText,
        prefixIcon: Icon(prefix),
      ),
    );

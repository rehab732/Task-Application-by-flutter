import 'dart:js';

import 'package:flutter/material.dart';
import 'package:testing/shared/cubit/cubit.dart';

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




    Widget buildtask(Map model,context)=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text('${model['title']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    Text('${model['date']}',
                    style: TextStyle(color:Colors.blue)),
          
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          IconButton(onPressed: (){
            AppCubit.get(context).updateDats(status: 'Done', id: model['id']);
          }, icon: Icon(Icons.check_box)),
          SizedBox(
            width: 20.0,
          ),
          IconButton(onPressed: (){
            AppCubit.get(context).updateDats(status: 'Archive', id: model['id']);
          }, icon: Icon(Icons.archive)),

        ],
      ),
    );

import 'package:flutter/material.dart';
import 'package:testing/shared/component/component.dart';
import 'package:testing/shared/component/constant.dart';

class Newtasksscreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context,index)=>buildtask(tasks[index]), separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height:1.0,
        color: Colors.grey[300],
      ),
    ), itemCount: tasks.length,);
  }
}

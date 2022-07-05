import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/shared/component/component.dart';
import 'package:testing/shared/cubit/cubit.dart';
import 'package:testing/shared/cubit/states.dart';

class Newtasksscreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) { 
        var tasks=AppCubit.get(context).newtasks;
        return ListView.separated(itemBuilder: (context,index)=>buildtask(tasks[index],context), separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0,
        ),
        child: Container(
          width: double.infinity,
          height:1.0,
          color: Colors.grey[300],
        ),
      ), itemCount: tasks.length,);
       },
       
    );
  }
}

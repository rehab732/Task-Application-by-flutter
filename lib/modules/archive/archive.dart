import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/component.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
class Archivescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) { 
        var tasks=AppCubit.get(context).archtasks;
        return taskBuilder(tasks: tasks);
       },
       
    );
  }

}
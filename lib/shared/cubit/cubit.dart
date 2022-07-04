import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/shared/cubit/states.dart';

import '../../modules/archive/archive.dart';
import '../../modules/done/done.dart';
import '../../modules/task/task.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppIninitialState());
  static AppCubit get(context)=>BlocProvider.of(context);//object
  int currentindex = 0;
  List<Widget> screens = [Newtasksscreen(), Donetaskscreen(), Archivescreen()];
  List<String> titels = ["New Tasks", "Done Tasks", "Archive Tasks"];

  void changeindex(int index)
  {
    currentindex=index;
    emit(AppChangeBottomNavBarState());
  }
  
}
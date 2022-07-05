import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import '../../modules/archive/archive.dart';
import '../../modules/done/done.dart';
import '../../modules/task/task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIninitialState());

  static AppCubit get(context) => BlocProvider.of(context); //object
  int currentindex = 0;
  List<Widget> screens = [Newtasksscreen(), Donetaskscreen(), Archivescreen()];
  List<String> titels = ["New Tasks", "Done Tasks", "Archive Tasks"];

  void changeindex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

 late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archtasks = [];

  void createDatabase() {
    openDatabase('taskaty.db', version: 1, onCreate: (database, version) {
      //called just one time
      print('database created');
      database
          .execute(
              'CREATE TABLE TASKS (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((onError) {
        print('Error while creating table ${onError.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('database opend');
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insrtintoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new task")')
          .then((value) {
        print('$value inserted');
        emit(AppInsertDatabase());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('error in inseret ${error.toString()}');
      });
    });
  }

 void getDataFromDataBase(database)  {
  newtasks=[];
  donetasks=[];
  archtasks=[];
    emit(AppGetDatabaseLoading());
     database.rawQuery('SELECT * FROM TASKS').then((value) {
        value.forEach((element)
        {
          if(element['status']=='new')
               newtasks.add(element);
          else if(element['status']=='done')
               donetasks.add(element);
          else archtasks.add(element);

        });

        emit(AppGetDatabase());
      });
  }

  void updateDats({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDAET tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDataBase(database);

          emit(rawUpdate());
    });
  }

  bool isbottomsheet = false;
  IconData iconadd = Icons.edit;
  void changebottomsheet({
    required bool isShow,
    required IconData icon,
  }) {
    isbottomsheet = isShow;
    iconadd = icon;
    emit(Appchange());
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/modules/archive/archive.dart';
import 'package:testing/modules/done/done.dart';
import 'package:testing/modules/task/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/shared/component/component.dart';

class Homelayout extends StatefulWidget {
  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  int currentindex = 0;
  List<Widget> screens = [Newtasksscreen(), Donetaskscreen(), Archivescreen()];
  List<String> titels = ["New Tasks", "Done Tasks", "Archive Tasks"];
  late Database database;
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool isbottomsheet = false;
  IconData iconadd = Icons.edit;
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  List<Map> tasks=[];
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: Scaffoldkey,
      appBar: AppBar(title: Text(titels[currentindex])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isbottomsheet) {
            insrtintoDatabase(title: titlecontroller.text, time: timecontroller.text, date: datecontroller.text);
            Navigator.pop(context);
            isbottomsheet = false;
            setState(() {
              iconadd = Icons.edit;
            });
          } else {
            Scaffoldkey.currentState!.showBottomSheet(
              (context) => Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    formfieldd(
                        controller: titlecontroller,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'title must not be empty';
                          }
                          return null;
                        },
                        labelText: 'Task Title',
                        prefix: Icons.title,
                        ispass: true,
                        onTap: () {
                          print('not null');
                        },
                        isclick: true),
                    SizedBox(
                      height: 10,
                    ),
                    formfieldd(
                        controller: timecontroller,
                        type: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2021-05-03'),
                          ).then((value) {
                            datecontroller.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'time must not be empty';
                          }

                          return null;
                        },
                        labelText: 'Task time',
                        prefix: Icons.watch_later_outlined,
                        ispass: true,
                        isclick: true),
                    SizedBox(
                      height: 10,
                    ),
                    formfieldd(
                        controller: datecontroller,
                        type: TextInputType.datetime,
                      
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-7-20'))
                              .then((value) {
                                datecontroller.text=DateFormat.yMMMd().format(value!);
                            
                          });
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'date must not be empty';
                          }
                        },
                        labelText: 'Task date',
                        prefix: Icons.date_range_outlined,
                        ispass: true,
                        isclick: true)
                  ],
                ),
              ),
              elevation: 20.0
            );
            isbottomsheet = true;
            setState(() {
              iconadd = Icons.add;
            });
          }

          //insrtintoDatabase(title: "rehabti", time: "bbbb", date: "bb");
        },
        // child: Icon(iconadd),
      ),
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 40,
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: "Task",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
              ),
              label: "Done",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.archive,
              ),
              label: "Archive",
            ),
          ]),
    );
  }

  void createDatabase() async {
    database = await openDatabase('taskaty.db', version: 1,
        onCreate: (database, version) {
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
      getDataFromDataBase(database).then((value){
        tasks=value;
        print(tasks);

      });
      print('database opend');
    });
  }

  Future insrtintoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new task")')
          .then((value) {
        print('$value inserted');
      }).catchError((error) {
        print('error in inseret ${error.toString()}');
      });
    });
  }
}
Future <List<Map>>getDataFromDataBase(database)async{
   return await database.rawQuery('SELECT * FROM TASKS');
  


}


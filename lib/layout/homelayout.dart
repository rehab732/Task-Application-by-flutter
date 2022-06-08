import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/modules/archive/archive.dart';
import 'package:testing/modules/done/done.dart';
import 'package:testing/modules/task/task.dart';
import 'package:sqflite/sqflite.dart';

class Homelayout extends StatefulWidget {
  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  int currentindex = 0;
  List<Widget> screens = [Newtasksscreen(), Donetaskscreen(), Archivescreen()];
  List<String> titels = ["New Tasks", "Done Tasks", "Archive Tasks"];
   late Database database;
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titels[currentindex])),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          insrtintoDatabase();
       
        },
        child: Icon(Icons.add),
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
    print('database opend');
  });
}

void insrtintoDatabase() {
  
  database.transaction((txn) async {
    txn
        .rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES("first task","02222","891","new task")')
        .then((value) {
      print('$value inserted');
    }).catchError((error) {
      print('error in inseret ${error.toString()}');
    });
    
  });
}
}






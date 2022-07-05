import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/shared/component/component.dart';
import 'package:testing/shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Homelayout extends StatelessWidget {
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: Scaffoldkey,
            appBar: AppBar(title: Text(cubit.titels[cubit.currentindex])),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isbottomsheet) {
                  if (formkey.currentState!.validate()) {
                    cubit.insrtintoDatabase(
                        title: titlecontroller.text,
                        time: timecontroller.text,
                        date: datecontroller.text);
                  }
                } else {
                  Scaffoldkey.currentState!
                      .showBottomSheet(
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
                                            lastDate:
                                                DateTime.parse('2022-7-20'))
                                        .then((value) {
                                      datecontroller.text =
                                          DateFormat.yMMMd().format(value!);
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
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changebottomsheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changebottomsheet(isShow: true, icon: Icons.add);
                }

                //insrtintoDatabase(title: "rehabti", time: "bbbb", date: "bb");
              },
              child: Icon(cubit.iconadd),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoading,
              builder: (context) => cubit.screens[cubit.currentindex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 40,
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.changeindex(index);
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
        },
      ),
    );
  }
}

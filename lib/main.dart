import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:testing/layout/homelayout.dart';
import 'package:testing/modules/counter/counter.dart';
import 'package:testing/shared/block_observer.dart';

void main() {
  //Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home:Homelayout(), 
    );
  }
}



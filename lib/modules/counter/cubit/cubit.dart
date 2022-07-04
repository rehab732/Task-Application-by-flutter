import'dart:js';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit():super(CounterInitialState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int counter=1;
  void minus()
  {
    counter--;
    emit(CounterminusState(counter));
    
  }
  void plus()
  {
    counter++;
    emit(CounterplusState(counter));
  }


}
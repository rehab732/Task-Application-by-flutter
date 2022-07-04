import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/modules/counter/cubit/cubit.dart';
import 'cubit/states.dart';

class Counter extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>CounterCubit(),
     child: BlocConsumer<CounterCubit,CounterStates>(
       listener: (context,state){
        if(state is CounterminusState)
        {
         // print('minus state ${state.counter}');
        }
        if(state is CounterplusState)
        {
         // print('plus state ${state.counter}}');
        }

       },
       builder: (context,state){
        return Scaffold(
          appBar: AppBar(title: Text('Counter')),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){
                    CounterCubit.get(context).minus();
                    
                  },
                  child: Text('MINUS'),
                ),
                SizedBox(width:20),
                Text('${CounterCubit.get(context).counter}'),
                TextButton(
                  onPressed: (){
                    CounterCubit.get(context).plus();
                   
                  },
                  child: Text('PLUS'),
                ),
        
              ],
            ),
          ),
        );
       },
     ),
   );
  }
}
  

  
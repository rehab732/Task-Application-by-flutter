abstract class CounterStates{}
class CounterInitialState extends CounterStates{}
class CounterplusState extends CounterStates{
 final  int counter;
 CounterplusState(this.counter);
  
}
class CounterminusState extends CounterStates{
   final  int counter;
 CounterminusState(this.counter);
}
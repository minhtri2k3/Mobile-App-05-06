import 'package:mobx/mobx.dart';
part 'counter_store.g.dart';
class CounterStore = _CounterStore with _$CounterStore;

abstract class _CounterStore with Store{
   @observable
   int counter  = 0;

   @observable
   String anoutment = 'Please press 2 button' ;

   @action
   void increment(){
      counter++;
   }

   @action
  void decrement(){
     counter--;
   }
   @action
  void increment_anount(){
     anoutment = 'You have pressed the plus';
   }

   @action
  void decrement_anout(){
     anoutment ='You have pressed the minus';
   }
}
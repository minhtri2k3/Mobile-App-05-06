import 'package:createtest2/store/counter_store.dart';
import 'package:flutter/material.dart';
// void CounterPress
import 'package:flutter_mobx/flutter_mobx.dart';
class CounterPage extends StatelessWidget{
  final CounterStore count = CounterStore();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
           title: Text('Test Mobx'),
          centerTitle: true,
        ),
        body: Center(
           child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget> [
                 Text(
                     'Counter',
                   style: TextStyle(fontSize: 30),
                 ),
                 Observer(
                     builder: (_)=> Text(
                         '${count.counter}',
                       style: TextStyle(fontSize: 40),
                     )
                 ),
                Row(
                   mainAxisAlignment:  MainAxisAlignment.center,
                   children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          count.increment();
                          count.increment_anount();
                        },
                        child: Icon(Icons.add),
                      ),
                      const SizedBox( width: 50,),
                      FloatingActionButton(
                          onPressed:(){
                            count.decrement();
                            count.decrement_anout();
                          },
                        child:  Icon(Icons.remove),
                      )
                   ],
                ),
                const SizedBox(height: 15),
                Observer(
                    builder: (_)=> Text(
                        '${count.anoutment}',
                      style: TextStyle(fontSize: 20),
                    ),
                )
              ],
           ),
        ),
    );
  }
    
}
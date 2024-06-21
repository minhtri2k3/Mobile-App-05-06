import 'dart:ui';

import 'package:createtest2/pages/counter_page.dart';
import 'package:createtest2/pages/flutter_login.dart';
import 'package:createtest2/service/app_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'models/personal.dart';
void main(){
   // runApp(TestMobx());
  //    runApp(MyApp());
  runApp(LogPage());
}
class TestMobx extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new MaterialApp(
         home:  CounterPage(),
      );
  }
}
class LogPage extends StatelessWidget{
  late final Dio dio;
  late final ApiClient client;
  LogPage() {
    dio = Dio(BaseOptions(contentType: "application/json"));
    client = ApiClient(dio);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
       home:  PageLogin(title: '', client: client,),
    );
    throw UnimplementedError();
  }

}
class User{
  final int id;
   String firstName;
  String lastName;
  String password;
  Personal personal;
   // User({required this.id, required this.firstName, required this.lastName, required this.password});
    User({required this.id, required this.firstName, required this.lastName, required this.password , required this.personal});

  factory User.fromJson(Map<String, dynamic> json){
    return User (
        id : json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        password: json['password'],
         personal: Personal.fromJson(json['personal']),        )
        ;
  }
}
class Personal {
  final int id;
  final String address;
  final String age;
  final String gender;

  Personal({
    required this.id,
    required this.address,
    required this.age,
    required this.gender,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'],
      address: json['Address'],
      age: json['Age'],
      gender: json['Gender'],
    );
  }
}

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;

  GradientIcon({super.key, required this.icon, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        color: Colors.white, // This color will be overridden by the shader mask
        size: 32.0, // Adjust the size of the icon as needed
      ),
    );
  }
}
LinearGradient getCustomGradient() {
  return const LinearGradient(
    colors: <Color>[Color(0xfff57689), Color(0xffecabe2)],
  );
}


class CustomErrorIndicator extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onTryAgain;

  const CustomErrorIndicator({
    Key? key,
    required this.errorMessage,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $errorMessage',
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: onTryAgain,
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  late final Dio dio;

  late final ApiClient client;

  MyApp() {
    dio = Dio(BaseOptions(contentType: "application/json"));
    client = ApiClient(dio);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '', client: client),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.client});
  final String title;
  final Dio dio = Dio(BaseOptions(contentType: "application/json"));
  final ApiClient client;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _pageSize = 20;
  int _onPressed  = 0;
  bool isVisible = false;
  int counter = 0;
  final PagingController<int , User> _pagingController = PagingController(firstPageKey:1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    // _fetchMoreUsers();
  }
  Future<void> _fetchPage(int pageKey) async{
    try {
      final newUsers = await widget.client.getUsersPagination(limit: _pageSize, page: pageKey);
      final isLastPage = newUsers.length  < _pageSize;
      if (isLastPage) {
        print("This is the last page");
        _pagingController.appendLastPage(newUsers);
      } else {
        print("Go to the next page");
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newUsers, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
      print("Error with the fetchPage");
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.black,
            flexibleSpace:Stack(
              children: <Widget>[
                Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xfff57689),
                              Color(0xffecabe2)
                            ],
                          ),
                        ),
                        child: const Row(

                          children: [
                            Column(

                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                               Positioned(
                                 left : 5,
                                 child: Text(
                                 'Total',
                                 style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                               ),

                                  Text(
                                    '\$7500.50',
                                    style: TextStyle(color: Colors.white, fontSize: 30),
                                  ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xfff9dfeb),
                              Color(0xfff9dfeb)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 20,
                  top: 115,
                  width: 740,
                  height: 50,// Set width to half of the screen width
                  child: FractionallySizedBox(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5, // Set the width factor to 0.5 to cover half of the parent's width
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                          ],
                        ),
                      ),
                      child:  const Row(
                        children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children :[
                                        Icon(
                                          Icons.trending_up,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 3,),
                                        Text('Income',
                                          style: TextStyle( color: Colors.grey),
                                        ),],

                                    ),
                                    Text('\$10,000.50',
                                      style: TextStyle( fontSize: 15 , color: Colors.green),
                                    )
                                  ],
                               )
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Expense'),
                                  Text('\$10,000.50')
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Transform.translate(
                offset: const Offset(0, -45), // Move the CircleAvatar up by 10 pixels
                child: const CircleAvatar(

                ),
              ),
            ),
          ],
        ),
        body:  Container(
          color: Color(0xfff9dfeb),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: PagedListView<int, User>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                transitionDuration : const Duration(microseconds: 500),
                itemBuilder: (context, user, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Today,03/23/2024'),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 10),
                                child: Text("Transaction",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: CircleAvatar(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(user.firstName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Text(user.lastName,
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "-\$${user.id}",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: CircleAvatar(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Car',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Text('Oil',
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("-\$200.00",
                                            style:
                                            TextStyle(color: Colors.red)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                firstPageErrorIndicatorBuilder: (context) => CustomErrorIndicator(
                  errorMessage: _pagingController.error?.toString() ?? 'Unknown error',
                  onTryAgain: () => _pagingController.refresh(),
                ),
                  noItemsFoundIndicatorBuilder: (context) => CustomErrorIndicator(
                    errorMessage: _pagingController.error?.toString() ?? 'API get error',
                    onTryAgain: () => _pagingController.refresh(),)
              ),

            ),
      ),
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfff57689),
                      Color(0xffecabe2)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 32.0,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color(0xfff9dfeb),
          notchMargin: 10,
          child: Container(

            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed : (){
                        setState(() {
                          _onPressed = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible : _onPressed!=1,
                            child: Icon(
                              Icons.home_filled,
                              color: Colors.black,
                            ),),
                          Visibility(
                            visible :  _onPressed == 1,
                            child:  GradientIcon(
                              // color: _onPressed == 1 ? Colors.blue : Colors.black,
                              gradientColors : [Color(0xfff57689),Color(0xffecabe2)], icon: Icons.home_filled,
                            ),
                          ),
                          Text(
                              'Homes'
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          _onPressed = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible : _onPressed!=2,
                            child: Icon(
                              Icons.pie_chart,
                              color: Colors.black,
                            ),),
                          Visibility(
                            visible : _onPressed ==2 ,
                            child:  GradientIcon(
                              // color: _onPressed == 1 ? Colors.blue : Colors.black,
                              gradientColors : [Color(0xfff57689),Color(0xffecabe2)], icon: Icons.pie_chart,
                            ),
                          ),
                          Text('Report'),
                        ],
                      ),
                    ),


                  ],
                ),
                // The right
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed : (){
                        setState(() {
                          _onPressed = 3;
                        });
                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible : _onPressed!=3,
                            child: Icon(
                              Icons.child_friendly,

                              color: Colors.black,
                            ),),
                          Visibility(
                            visible :  _onPressed == 3,
                            child:  GradientIcon(
                              // color: _onPressed == 1 ? Colors.blue : Colors.black,
                              gradientColors : [Color(0xfff57689),Color(0xffecabe2)], icon: Icons.child_friendly,
                            ),
                          ),
                          Text(
                              'Kid'
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed : (){
                        setState(() {
                          _onPressed = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible : _onPressed!=4,
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Colors.black,
                            ),),
                          Visibility(
                            visible :  _onPressed == 4,
                            child:  GradientIcon(
                              // color: _onPressed == 1 ? Colors.blue : Colors.black,
                              gradientColors : [Color(0xfff57689),Color(0xffecabe2)], icon: Icons.person_2_outlined,
                            ),
                          ),
                          Text(
                              'Me'
                          )
                        ],
                      ),
                    ),


                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      );

  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

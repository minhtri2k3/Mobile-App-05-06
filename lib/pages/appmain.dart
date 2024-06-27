import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../service/app_client.dart';
import 'flutter_login.dart';

void main(){
  // runApp(TestMobx());
  //    runApp(MyApp());
   runApp(LogPage());
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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../secure/flutter_secure_storage.dart';
import '../service/app_client.dart';


class PageLogin extends StatefulWidget {
  PageLogin({super.key , required this.title , required this.client});
  final String title;
  final Dio dio = Dio(BaseOptions(contentType: "application/json"));
  final ApiClient client;
  @override
  _PageLoginState createState() => _PageLoginState();


}

class _PageLoginState extends State<PageLogin>{
  final SecureStorage secureStorage = SecureStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio dio = Dio();
  late ApiClient apiClient;
  Future<void> _login() async {
    try {
      await loginAndSaveJwt(apiClient, _emailController.text, _passwordController.text);
      setState(() {
        // Update UI or navigate to another screen
        print("Login success");
      });
    } catch (e) {
      print("Login failed: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    apiClient = ApiClient(dio, baseUrl: 'http://10.0.2.2:3000');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
       appBar: AppBar(
         title: Text('Login screen'),
         centerTitle: true,
       ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
               children: <Widget>[
                 SizedBox(height: 50),

                 Text(
                     'Username',
                    style: TextStyle(
                       fontSize: 20
                    ),
                 ),
                 TextField(
                    controller: _emailController,
                    decoration:  InputDecoration(
                       labelText: 'Email',

                    ),
                 ),

                 SizedBox(height: 20),
                 Text(
                     'Password',
                   style: TextStyle(
                      fontSize: 20
                   ),
                 ),
                 TextField(
                    controller:  _passwordController,
                   decoration: InputDecoration(
                      labelText: 'Password',
                   ),
                 ),
                 SizedBox(height: 30,),
                 ElevatedButton(
                     onPressed: _login,
                     child: Text('Login')
                 )
               ],
            ),
          ),
      ),
    );


    throw UnimplementedError();
  }
  
}
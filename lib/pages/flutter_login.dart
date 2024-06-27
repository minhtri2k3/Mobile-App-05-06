import 'package:createtest2/models/access_token.dart';
import 'package:createtest2/models/login_request.dart';
import 'package:createtest2/store/check_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../models/error_response.dart';
import '../secure/flutter_secure_storage.dart';
import '../service/app_client.dart';
import 'member.dart';


class PageLogin extends StatefulWidget {
  PageLogin({super.key , required this.title , required this.client});
  final String title;
  final Dio dio = Dio(BaseOptions(contentType: "application/json"));
  final ApiClient client;
  @override
  _PageLoginState createState() => _PageLoginState();


}

class _PageLoginState extends State<PageLogin>{
  late final AccessToken LoginAccessToken;
  final SecureStorage secureStorage = SecureStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio dio = Dio();
  late ApiClient apiClient;
  final checkLogin = CheckLogin();
  @override
  void initState() {
    super.initState();
    apiClient = ApiClient(dio);
  }
  Future<void> _login(String email, String password) async {
    try {
      final loginRequest = LoginRequest(email: email, password: password);
      LoginAccessToken = await apiClient.login(loginRequest);
      // Handle successful response


      // Save the access token
      await secureStorage.storeJwt(key : 'jwt', value : LoginAccessToken.access_token);
      // Navigate to another page or show success message
      checkLogin.logined();
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        final errorResponse = ErrorResponse.fromJson(e.response?.data);
        // Handle unauthorized error
        print("Error: ${errorResponse.message}, Status Code: ${errorResponse.statusCode}");
        // Show error message to the user
      } else {
        // Handle other errors
        print("Error: ${e.message}");
        // Show error message to the user
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   return Observer(
       builder:(_){
         if(checkLogin.isLoggedIn){
           Future.microtask((){
             Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context)=> SecondPage(
                     title:'Information',
                     client: apiClient,
                     accessToken: LoginAccessToken,
                   )
                   ),
             );
           });
         }
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
                       onPressed:()=> _login(_emailController.text , _passwordController.text),
                       child: Text('Login')
                   )
                 ],
               ),
             ),
           ),
         );
       }
   );


    throw UnimplementedError();
  }

}
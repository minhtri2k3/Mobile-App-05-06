
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/access_token.dart';
import '../models/login_request.dart';
import '../models/user.dart';
import '../secure/flutter_secure_storage.dart';


part 'app_client.g.dart';
//10.0.2.2
@RestApi(baseUrl: "http://10.0.2.2:3000")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/users")
  Future<List<User>> getAllUsers();

  @GET("/users/{id}")
  Future<User> getUser(@Path("id") int id);
  @GET("/users")
  Future<List<User>> getUsersPagination({
    @Query("limit")   required int limit ,
    @Query("page")  required int page
  });

  @POST("/users/login")
   Future <AccessToken> login(@Body() LoginRequest loginRequest);

  @GET("/users/info")
   Future < User > getInfor (@Header("Authorization") String token );

}



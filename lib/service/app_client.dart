import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../main.dart';


part 'app_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/users")
  Future<List<User>> getAllUsers();

  @GET("/users/{id}")
  Future<User> getUser(@Path("id") int id);
  @GET("/users")
  Future<List<User>> getUsersPagination({
    @Query("limit")   required int limit ,
    @Query("page")  required int page
  });

}

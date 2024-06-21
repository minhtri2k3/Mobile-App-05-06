
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../main.dart';
import '../secure/flutter_secure_storage.dart';


part 'app_client.g.dart';
//10.0.2.2
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

  @POST("/users/login")
   Future <AccessToken> login(@Body() LoginRequest loginRequest);
     
   
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class AccessToken {
  final String accessToken;
  AccessToken({required this.accessToken});
  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      AccessToken(accessToken: json['access_token']);
}
Future<void> loginAndSaveJwt(ApiClient apiClient, String email, String password) async {
  final secureStorage = SecureStorage();
  try {
    final loginRequest = LoginRequest(email: email, password: password);
    final response = await apiClient.login(loginRequest);
    await secureStorage.storeJwt(response.accessToken);
    print("Login successful, JWT saved.");
  } catch (e) {
    print("Login failed: $e");
  }
}
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../main.dart';


part 'app_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

 

}

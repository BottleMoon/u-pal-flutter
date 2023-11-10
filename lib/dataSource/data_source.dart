import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:u_pal/model/token.dart';

class DataSource {
  final Dio dio = Dio();

  DataSource() {
    dio.interceptors.add(CustomInterceptor());
  }

  Future<Token?> signIn(String email, String password) async {
    Response res = await dio.post(dotenv.env['SIGN_IN_URL']!,
        data: {'email': email, 'password': password},
        options: Options(contentType: Headers.jsonContentType));

    if (res.statusCode == 200) {
      return Token.fromJson(res.data);
    }

    return null;
  }

  void signUp(String email, String password, String nickname, int age,
      String country) async {
    Response res = await dio.post(dotenv.env['SIGN_UP_URL']!,
        data: {
          'email': email,
          'password': password,
          'nickname': nickname,
          'age': age,
          'country': country
        },
        options: Options(contentType: Headers.jsonContentType));
  }

// Future<bool> confirmEmail() async {
//   //TODO: 이메일 인증
// }
}

class CustomInterceptor extends Interceptor {
  final storage = const FlutterSecureStorage();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await storage.read(key: 'accessToken');
    var refreshToken = await storage.read(key: 'refreshToken');
    if (token != null && refreshToken != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

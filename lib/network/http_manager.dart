import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
    baseUrl: 'https://i.jandan.net/',
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: {
//      'user-agent': 'dio',
      'api': '1.0.0',
    },
    validateStatus: (status) {
      return status >= 200 && status < 300 || status == 304;
    }
));


Dio getDio(){
  return dio;
}
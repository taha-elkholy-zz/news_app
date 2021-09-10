import 'package:dio/dio.dart';

// don't forget to init this class in your runApp method
class DioHelper {
  // get a static object of the Dio
  static late Dio dio;

  // static method for init the dio
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true),
    );
  }

  // get data
  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query);
  }
}

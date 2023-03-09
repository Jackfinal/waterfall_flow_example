///
/// @Author: jack
/// @Date: 2/4/23 8:12 PM
/// @Email: final_m@foxmail.com
///
import 'package:dio/dio.dart';
const String apiServiceKey = "api";

class Api {

  static Dio init() {
    final Dio dio = Dio();
    dio.options.headers = {
      "Access-Control-Allow-Origin": "*",
    };
    dio.options.baseUrl = "https://api.wanjia.zhuokearts.com"; //此处只是默认的baseUrl  可通过路由改变baseUrl

//    dio.options.contentType = "application/json";
    //这里还可以添加其他插件
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }

}
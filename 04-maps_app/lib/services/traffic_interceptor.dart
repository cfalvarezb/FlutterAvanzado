import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiY2ZhbGJhcmVzYiIsImEiOiJjbHYybGlpaGYwaTR5MzBuc28xbjJtb3EwIn0.qVSaQ2LRjyBoZTPyOlAvVQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }

}
import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiY2ZhbGJhcmVzYiIsImEiOiJjbHYybGlpaGYwaTR5MzBuc28xbjJtb3EwIn0.qVSaQ2LRjyBoZTPyOlAvVQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest

    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });

    super.onRequest(options, handler);
  }

}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  // token de auth
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Opcion para manejo de token a las peticiones si fuera el caso
    if (_authToken != null) {
      options.headers['Authorization'] = 'Bearer $_authToken';
    }

    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('Headers: ${options.headers}');
    
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('Message: ${err.message}');
    
    // Manejo errores globales
    if (err.response?.statusCode == 401) {
      // TODO: Navegar a login o refrescar token
      debugPrint('Token invalido - Redirigir a login');
    }
    
    return super.onError(err, handler);
  }
}
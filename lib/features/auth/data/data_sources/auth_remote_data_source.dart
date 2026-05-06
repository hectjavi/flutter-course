import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/api_constants.dart';
import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/features/auth/data/models/auth_user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    final username = await _resolveUsername(email);
    final response = await _dioClient.post(
      ApiConstants.login,
      data: {'username': username, 'password': password, 'expiresInMins': 30},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    return AuthUserModel.fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<String> _resolveUsername(String email) async {
    final response = await _dioClient.get(
      ApiConstants.usersFilter,
      queryParameters: {'key': 'email', 'value': email},
    );
    final data = Map<String, dynamic>.from(response.data);
    final users = data['users'] as List<dynamic>? ?? [];

    if (users.isEmpty) {
      throw Exception('No existe un usuario registrado con ese email.');
    }

    final user = Map<String, dynamic>.from(users.first);
    return user['username'] as String;
  }
}

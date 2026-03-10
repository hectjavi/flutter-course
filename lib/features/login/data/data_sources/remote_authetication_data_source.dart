import 'package:flutter_application_1/core/network/dio_client.dart';
//import 'package:flutter_application_1/core/network/api_constants.dart';
import 'package:flutter_application_1/features/login/data/models/user_model.dart';
import 'package:flutter_application_1/features/login/data/models/user_password_model.dart';

class RemoteAutheticationDataSource {
  final DioClient _dioClient;

  // Inyección de dependencias - permite mock en tests
  RemoteAutheticationDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<UserModel> signIUpWithEmailAndPassword(
    UserPasswordModel userPasswordModel,
  ) async {
    final email = userPasswordModel.email;
    final password = userPasswordModel.password;

    try {
      // ejemplo cuando exista back real
      // final response = await _dioClient.post(
      //   ApiConstants.login, // o ApiConstants.register según tu endpoint
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );
      // 
      // return UserModel.fromJson(response.data['user']);

      // MOCK 
      await Future.delayed(const Duration(seconds: 2));

      if (email == 'jaldana' && password == '123456') {
        return UserModel(
          id: '123',
          email: userPasswordModel.email,
          name: 'Javier Aldana',
        );
      } else {
        throw Exception('Error al registrar el usuario. Credenciales inválidas.');
      }

    } catch (e) {
      throw Exception('Error de autenticación: $e');
    }
  }

  // Método login 
  Future<UserModel> loginWithEmailAndPassword(
    UserPasswordModel userPasswordModel,
  ) async {
    final email = userPasswordModel.email;
    final password = userPasswordModel.password;

    try {
      // Ejemplo para backend invoke
      // final response = await _dioClient.post(
      //   ApiConstants.login,
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );
      // 
      // // Guardar token en interceptor 
      // final token = response.data['token'];
      // if (token != null) {
      //   _dioClient.dio.options.headers['Authorization'] = 'Bearer $token';
      // }
      // 
      // return UserModel.fromJson(response.data['user']);

      // MOCK
      await Future.delayed(const Duration(seconds: 2));

      if (email == 'jaldana' && password == '123456') {
        return UserModel(
          id: '123',
          email: userPasswordModel.email,
          name: 'Javier Aldana',
        );
      } else {
        throw Exception('Credenciales inválidas.');
      }

    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      // ejemplo cuando exista backend
      // await _dioClient.post(ApiConstants.logout);
      
      // Limpiar token de los headers
      _dioClient.dio.options.headers.remove('Authorization');
      
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }
}
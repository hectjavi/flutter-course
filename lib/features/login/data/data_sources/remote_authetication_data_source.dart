import 'package:flutter_application_1/features/login/data/models/user_model.dart';
import 'package:flutter_application_1/features/login/data/models/user_password_model.dart';

class RemoteAutheticationDataSource {
  Future<UserModel> signIUpWithEmailAndPassword(
    UserPasswordModel userPasswordModel,
  ) async {
    final email = userPasswordModel.email;
    final password = userPasswordModel.password;
    await Future.delayed(
      Duration(seconds: 2),
    ); 

    if (email == 'jmanu' && password == '123456') {

      return UserModel(
        id: '123',
        email: userPasswordModel.email,
        name: 'Juan Manuel',
      );
    } else {
      throw Exception('Error al registrar el usuario. Credenciales inválidas.');
    }
  }
}
import 'dart:ui';
import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/core/network/api_constants.dart';
import 'package:flutter_application_1/features/login/data/models/user_settings_model.dart';

class SettingsRemoteDataSource {
  final DioClient _dioClient;

  SettingsRemoteDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<UserSettingsModel> getUserSettings() async {
    try {
      // DESCOMENTAR CUANDO TENGAS BACKEND:
      // final response = await _dioClient.get(ApiConstants.userSettings);
      // return UserSettingsModel.fromJson(response.data);

      // MOCK - Configuración inicial
      await Future.delayed(const Duration(milliseconds: 500));
      return UserSettingsModel(
        displayName: 'Javier Aldana',
        avatarAsset: 'assets/avatars/avatar1.png',
        headerColor: 'blue',
      );

    } catch (e) {
      throw Exception('Error al obtener configuración: $e');
    }
  }

  Future<void> updateDisplayName(String name) async {
    try {
      // DESCOMENTAR CUANDO TENGAS BACKEND:
      // await _dioClient.put(
      //   ApiConstants.userSettings,
      //   data: {'displayName': name},
      // );

      // MOCK
      await Future.delayed(const Duration(milliseconds: 400));
      print('Nombre actualizado: $name');

    } catch (e) {
      throw Exception('Error al actualizar nombre: $e');
    }
  }

  Future<void> updateAvatar(String avatarAsset) async {
    try {
      // DESCOMENTAR CUANDO TENGAS BACKEND:
      // await _dioClient.put(
      //   ApiConstants.userSettings,
      //   data: {'avatarAsset': avatarAsset},
      // );

      // MOCK
      await Future.delayed(const Duration(milliseconds: 400));
      print('Avatar actualizado: $avatarAsset');

    } catch (e) {
      throw Exception('Error al actualizar avatar: $e');
    }
  }

  Future<void> updateHeaderColor(String color) async {
    try {
      // DESCOMENTAR CUANDO TENGAS BACKEND:
      // await _dioClient.put(
      //   ApiConstants.userSettings,
      //   data: {'headerColor': color},
      // );

      // MOCK
      await Future.delayed(const Duration(milliseconds: 400));
      print('Color actualizado: $color');

    } catch (e) {
      throw Exception('Error al actualizar color: $e');
    }
  }

  // Avatares disponibles (mock)
  List<Map<String, String>> getAvailableAvatars() => [
        {'id': 'avatar1', 'asset': 'assets/avatars/avatar1.png', 'name': 'Clásico'},
        {'id': 'avatar2', 'asset': 'assets/avatars/avatar2.png', 'name': 'Moderno'},
        {'id': 'avatar3', 'asset': 'assets/avatars/avatar3.png', 'name': 'Ejecutivo'},
        {'id': 'avatar4', 'asset': 'assets/avatars/avatar4.png', 'name': 'Casual'},
        {'id': 'avatar5', 'asset': 'assets/avatars/avatar5.png', 'name': 'Creativo'},
      ];

  // Colores disponibles
  List<Map<String, dynamic>> getAvailableColors() => [
        {'id': 'blue', 'name': 'Azul Profesional', 'color': const Color(0xFF006FFD)},
        {'id': 'green', 'name': 'Verde Natural', 'color': const Color(0xFF00C853)},
        {'id': 'purple', 'name': 'Púrpura Real', 'color': const Color(0xFF7C4DFF)},
        {'id': 'orange', 'name': 'Naranja Energía', 'color': const Color(0xFFFF6D00)},
        {'id': 'red', 'name': 'Rojo Pasión', 'color': const Color(0xFFFF1744)},
      ];
}
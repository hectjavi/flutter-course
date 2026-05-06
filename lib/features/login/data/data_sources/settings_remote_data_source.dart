import 'dart:ui';
import 'package:flutter_application_1/features/login/data/models/user_settings_model.dart';

class SettingsRemoteDataSource {
  Future<UserSettingsModel> getUserSettings() async {
    try {
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
      await Future.delayed(const Duration(milliseconds: 400));
    } catch (e) {
      throw Exception('Error al actualizar nombre: $e');
    }
  }

  Future<void> updateAvatar(String avatarAsset) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
    } catch (e) {
      throw Exception('Error al actualizar avatar: $e');
    }
  }

  Future<void> updateHeaderColor(String color) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
    } catch (e) {
      throw Exception('Error al actualizar color: $e');
    }
  }

  List<Map<String, String>> getAvailableAvatars() => [
    {'id': 'avatar1', 'asset': 'assets/avatars/avatar1.png', 'name': 'Clásico'},
    {'id': 'avatar2', 'asset': 'assets/avatars/avatar2.png', 'name': 'Moderno'},
    {
      'id': 'avatar3',
      'asset': 'assets/avatars/avatar3.png',
      'name': 'Ejecutivo',
    },
    {'id': 'avatar4', 'asset': 'assets/avatars/avatar4.png', 'name': 'Casual'},
    {
      'id': 'avatar5',
      'asset': 'assets/avatars/avatar5.png',
      'name': 'Creativo',
    },
  ];

  List<Map<String, dynamic>> getAvailableColors() => [
    {
      'id': 'blue',
      'name': 'Azul Profesional',
      'color': const Color(0xFF006FFD),
    },
    {'id': 'green', 'name': 'Verde Natural', 'color': const Color(0xFF00C853)},
    {'id': 'purple', 'name': 'Púrpura Real', 'color': const Color(0xFF7C4DFF)},
    {
      'id': 'orange',
      'name': 'Naranja Energía',
      'color': const Color(0xFFFF6D00),
    },
    {'id': 'red', 'name': 'Rojo Pasión', 'color': const Color(0xFFFF1744)},
  ];
}

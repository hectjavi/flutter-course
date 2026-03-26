import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/data/models/user_settings_model.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_settings_usecase.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/update_settings_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  SettingsProvider({
    GetSettingsUseCase? getSettingsUseCase,
    UpdateSettingsUseCase? updateSettingsUseCase,
  })  : _getSettingsUseCase = getSettingsUseCase ?? GetSettingsUseCase(),
        _updateSettingsUseCase = updateSettingsUseCase ?? UpdateSettingsUseCase();

  // Estado
  UserSettingsModel? _settings;
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Controladores
  final TextEditingController _nameController = TextEditingController();

  // Getters
  UserSettingsModel? get settings => _settings;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;
  TextEditingController get nameController => _nameController;

  // Opciones disponibles
  final List<Map<String, String>> _availableAvatars = [];
  final List<Map<String, dynamic>> _availableColors = [];

  List<Map<String, String>> get availableAvatars => _availableAvatars;
  List<Map<String, dynamic>> get availableColors => _availableColors;

  Future<void> loadSettings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _settings = await _getSettingsUseCase();
      _nameController.text = _settings!.displayName;
      
      // Cargar opciones
      // _availableAvatars = _updateSettingsUseCase._repository.getAvailableAvatars();
      // _availableColors = _updateSettingsUseCase._repository.getAvailableColors();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar configuración: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDisplayName() async {
    if (_nameController.text.trim().isEmpty) {
      _error = 'El nombre no puede estar vacío';
      notifyListeners();
      return;
    }

    _isSaving = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      await _updateSettingsUseCase.updateName(_nameController.text.trim());
      
      // Actualizar localmente
      _settings = UserSettingsModel(
        displayName: _nameController.text.trim(),
        avatarAsset: _settings!.avatarAsset,
        headerColor: _settings!.headerColor,
      );
      
      _successMessage = 'Nombre actualizado correctamente';
      _isSaving = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al guardar: $e';
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateAvatar(String avatarAsset) async {
    _isSaving = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      await _updateSettingsUseCase.updateAvatar(avatarAsset);
      
      _settings = UserSettingsModel(
        displayName: _settings!.displayName,
        avatarAsset: avatarAsset,
        headerColor: _settings!.headerColor,
      );
      
      _successMessage = 'Avatar actualizado';
      _isSaving = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cambiar avatar: $e';
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateHeaderColor(String color) async {
    _isSaving = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      await _updateSettingsUseCase.updateColor(color);
      
      _settings = UserSettingsModel(
        displayName: _settings!.displayName,
        avatarAsset: _settings!.avatarAsset,
        headerColor: color,
      );
      
      _successMessage = 'Tema actualizado';
      _isSaving = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cambiar tema: $e';
      _isSaving = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
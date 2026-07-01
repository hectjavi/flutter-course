import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/features/dashboard/data/models/account_model.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    AccountModel? account,
    @Default(false) bool isLoading,
    String? error,
    @Default('¡Bienvenido de nuevo!')
    String welcomeMessage,
  }) = _DashboardState;
}
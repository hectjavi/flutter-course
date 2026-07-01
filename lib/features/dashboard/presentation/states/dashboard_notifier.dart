import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:flutter_application_1/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_application_1/features/dashboard/domain/use_cases/get_account_summary_usecase.dart';

import 'dashboard_state.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(),
);

class DashboardNotifier extends StateNotifier<DashboardState> {
  final GetAccountSummaryUseCase _getAccountSummaryUseCase;

  DashboardNotifier()
      : _getAccountSummaryUseCase = GetAccountSummaryUseCase(
          repository: DashboardRepositoryImpl(
            remoteDataSource: DashboardRemoteDataSource(),
          ),
        ),
        super(const DashboardState());

  Future<void> loadAccountSummary() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final account = await _getAccountSummaryUseCase();

      state = state.copyWith(
        account: account,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar la información: $e',
      );
    }
  }

  void updateWelcomeMessage(String message) {
    state = state.copyWith(
      welcomeMessage: message,
    );
  }
}
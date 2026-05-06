import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/app_routes.dart';
import 'package:flutter_application_1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_state.dart';
import 'package:flutter_application_1/features/auth/presentation/views/login_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/dashboard_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/history_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/settings_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/transfer_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final location = state.matchedLocation;
      final isPublicRoute =
          location == AppRoutes.login || location == AppRoutes.splash;

      return authState.when(
        checkingSession: () {
          return location == AppRoutes.splash ? null : AppRoutes.splash;
        },
        unauthenticated: () {
          if (location == AppRoutes.splash) {
            return AppRoutes.login;
          }
          return isPublicRoute ? null : AppRoutes.login;
        },
        loading: () {
          return isPublicRoute ? null : AppRoutes.login;
        },
        authenticated: (_) {
          return isPublicRoute ? AppRoutes.dashboard : null;
        },
        error: (_) {
          if (location == AppRoutes.splash) {
            return AppRoutes.login;
          }
          return isPublicRoute ? null : AppRoutes.login;
        },
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: AppRoutes.transfer,
        builder: (context, state) => const TransferView(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryView(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
});

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) => notifyListeners(),
    );
  }

  final Ref _ref;
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator(color: Color(0xFF006FFD))),
    );
  }
}

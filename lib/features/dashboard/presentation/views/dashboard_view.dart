import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/app_routes.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_notifier.dart';
import 'package:flutter_application_1/features/dashboard/presentation/states/dashboard_notifier.dart';
import 'package:flutter_application_1/features/dashboard/presentation/widgets/dashboard_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:go_router/go_router.dart';

class DashboardView extends riverpod.ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  riverpod.ConsumerState<DashboardView> createState() =>
      _DashboardViewState();
}

class _DashboardViewState
    extends riverpod.ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(dashboardProvider.notifier).loadAccountSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      body: DashboardBody(),
    );
  }
}

class DashboardBody extends riverpod.ConsumerWidget {
  const DashboardBody({super.key});

  @override
  Widget build(
    BuildContext context,
    riverpod.WidgetRef ref,
  ) {
    final state = ref.watch(dashboardProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(dashboardProvider.notifier)
                .loadAccountSummary();
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: 30,
                  left: constraints.maxWidth > 600
                      ? (constraints.maxWidth - 600) / 2
                      : 24,
                  right: constraints.maxWidth > 600
                      ? (constraints.maxWidth - 600) / 2
                      : 24,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF006FFD), Color(0xFF0051D4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        WelcomeHeaderWidget(),
                        LogoutButton(),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600
                      ? (constraints.maxWidth - 600) / 2
                      : 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    if (state.isLoading)
                      const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF006FFD),
                          ),
                        ),
                      )
                    else if (state.error != null)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red.shade400,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                      dashboardProvider
                                          .notifier,
                                    )
                                    .loadAccountSummary();
                              },
                              child:
                                  const Text('Reintentar'),
                            ),
                          ],
                        ),
                      )
                    else if (state.account != null)
                      AccountCardWidget(
                        account: state.account!,
                      ),

                    const SizedBox(height: 32),

                    const Text(
                      'Opciones',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),

                    const SizedBox(height: 16),

                    QuickActionCard(
                      title: 'Transferencias',
                      subtitle:
                          'Envía dinero a cualquier cuenta',
                      icon: Icons.arrow_forward,
                      color: const Color(0xFF006FFD),
                      onTap: () {
                        context.push(AppRoutes.transfer);
                      },
                    ),

                    const SizedBox(height: 12),

                    QuickActionCard(
                      title:
                          'Historial de Movimientos',
                      subtitle:
                          'Revisa tus transacciones recientes',
                      icon: Icons.receipt_long,
                      color: const Color(0xFF00C853),
                      onTap: () {
                        context.push(AppRoutes.history);
                      },
                    ),

                    const SizedBox(height: 12),

                    QuickActionCard(
                      title: 'Configuración',
                      subtitle:
                          'Personaliza tu experiencia',
                      icon: Icons.tune,
                      color: const Color(0xFFFF6D00),
                      onTap: () {
                        context.push(AppRoutes.settings);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LogoutButton extends riverpod.ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(
    BuildContext context,
    riverpod.WidgetRef ref,
  ) {
    return IconButton(
      tooltip: 'Cerrar sesión',
      style: IconButton.styleFrom(
        backgroundColor:
            Colors.white.withValues(alpha: 0.2),
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        ref
            .read(authControllerProvider.notifier)
            .logout();
      },
      icon: const Icon(Icons.logout),
    );
  }
}

class WelcomeHeaderWidget extends riverpod.ConsumerWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(
    BuildContext context,
    riverpod.WidgetRef ref,
  ) {
    final message = ref
        .watch(dashboardProvider)
        .welcomeMessage;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '¿Qué deseas hacer hoy?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
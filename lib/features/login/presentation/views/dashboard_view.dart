import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/presentation/states/dashboard_provider.dart';
import 'package:flutter_application_1/features/login/presentation/views/history_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/settings_view.dart';
import 'package:flutter_application_1/features/login/presentation/views/transfer_view.dart';
import 'package:flutter_application_1/features/login/presentation/widgets/dashboard_widgets.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadAccountSummary(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF7F9FC),
        body: DashboardBody(),
      ),
    );
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DashboardBody oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<DashboardProvider>().loadAccountSummary();
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Header con gradiente
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const WelcomeHeaderWidget(),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Contenido principal
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600
                      ? (constraints.maxWidth - 600) / 2
                      : 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tarjeta de cuenta con Consumer para reactividad
                    Consumer<DashboardProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF006FFD),
                              ),
                            ),
                          );
                        }

                        if (provider.error != null) {
                          return Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(16),
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
                                  provider.error!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: provider.loadAccountSummary,
                                  child: const Text('Reintentar'),
                                ),
                              ],
                            ),
                          );
                        }

                        if (provider.account == null) {
                          return const SizedBox.shrink();
                        }

                        return AccountCardWidget(account: provider.account!);
                      },
                    ),

                    const SizedBox(height: 32),

                    // Acciones rápidas
                    // const Text(
                    //   'Acciones Rápidas',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: Color(0xFF1A1A1A),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ActionButtonWidget(
                    //       icon: Icons.send,
                    //       label: 'Transferir',
                    //       color: const Color(0xFF006FFD),
                    //       onTap: () {
                    //         context
                    //             .read<DashboardProvider>()
                    //             .navigateToTransfers(context);
                    //       },
                    //     ),
                    //     ActionButtonWidget(
                    //       icon: Icons.history,
                    //       label: 'Historial',
                    //       color: const Color(0xFF00C853),
                    //       onTap: () {
                    //         context
                    //             .read<DashboardProvider>()
                    //             .navigateToHistory(context);
                    //       },
                    //     ),
                    //     ActionButtonWidget(
                    //       icon: Icons.settings,
                    //       label: 'Ajustes',
                    //       color: const Color(0xFFFF6D00),
                    //       onTap: () {
                    //         context
                    //             .read<DashboardProvider>()
                    //             .navigateToSettings(context);
                    //       },
                    //     ),
                    //   ],
                    // ),

                    // const SizedBox(height: 32),

                    // Opciones adicionales
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
                      subtitle: 'Envía dinero a cualquier cuenta',
                      icon: Icons.arrow_forward,
                      color: const Color(0xFF006FFD),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const TransferView())
                          );
                      },
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      title: 'Historial de Movimientos',
                      subtitle: 'Revisa tus transacciones recientes',
                      icon: Icons.receipt_long,
                      color: const Color(0xFF00C853),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const HistoryView())
                          );
                      },
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      title: 'Configuración',
                      subtitle: 'Personaliza tu experiencia',
                      icon: Icons.tune,
                      color: const Color(0xFFFF6D00),
                      onTap: () {
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const SettingsView())
                          );
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

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<DashboardProvider>().welcomeMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
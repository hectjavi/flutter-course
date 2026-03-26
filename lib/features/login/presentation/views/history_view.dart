import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/presentation/states/history_provider.dart';
import 'package:flutter_application_1/features/login/presentation/widgets/history_widgets.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryProvider()..loadInitialData(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF7F9FC),
        body: HistoryBody(),
      ),
    );
  }
}

class HistoryBody extends StatefulWidget {
  const HistoryBody({super.key});

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<HistoryProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Header
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
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Historial de Movimientos',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Contenido
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
                          if (provider.isLoading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else ...[
                            // Selector de cuenta
                            const Text(
                              'Seleccionar Cuenta',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(height: 16),
                            AccountSelectorChip(
                              accounts: provider.accounts,
                              selectedAccount: provider.selectedAccount,
                              onSelect: provider.selectAccount,
                            ),

                            const SizedBox(height: 24),

                            // Resumen
                            SummaryCard(
                              income: provider.totalIncome,
                              expenses: provider.totalExpenses,
                              transfers: provider.totalTransfers,
                            ),

                            const SizedBox(height: 24),

                            // Título de transacciones
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Transacciones Recientes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                                if (provider.isLoadingTransactions)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Lista de transacciones
                            if (provider.transactions.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.receipt_long_outlined,
                                        size: 64,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No hay transacciones',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              ...provider.transactions.map((transaction) {
                                return TransactionListItem(
                                  transaction: transaction,
                                  onTap: () {
                                    provider.selectTransaction(transaction);
                                    _showDetailModal(context, provider);
                                  },
                                );
                              }),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDetailModal(BuildContext context, HistoryProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailModal(
        transaction: provider.selectedTransaction!,
        onClose: () {
          Navigator.pop(context);
          provider.clearSelectedTransaction();
        },
      ),
    );
  }
}

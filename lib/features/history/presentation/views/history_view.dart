import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/history/presentation/states/history_notifier.dart';
import 'package:flutter_application_1/features/history/presentation/widgets/history_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<HistoryView> createState() =>
      _HistoryViewState();
}

class _HistoryViewState
    extends ConsumerState<HistoryView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(historyProvider.notifier)
          .loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      body: HistoryBody(),
    );
  }
}

class HistoryBody extends ConsumerWidget {
  const HistoryBody({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(historyProvider);
    final notifier =
        ref.read(historyProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top:
                        MediaQuery.of(context)
                                .padding
                                .top +
                            20,
                    bottom: 30,
                    left:
                        constraints.maxWidth >
                                600
                            ? (constraints
                                        .maxWidth -
                                    600) /
                                2
                            : 24,
                    right:
                        constraints.maxWidth >
                                600
                            ? (constraints
                                        .maxWidth -
                                    600) /
                                2
                            : 24,
                  ),
                  decoration:
                      const BoxDecoration(
                    gradient:
                        LinearGradient(
                      colors: [
                        Color(0xFF006FFD),
                        Color(0xFF0051D4),
                      ],
                      begin:
                          Alignment.topLeft,
                      end:
                          Alignment
                              .bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.only(
                      bottomLeft:
                          Radius.circular(
                        30,
                      ),
                      bottomRight:
                          Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon:
                                const Icon(
                              Icons
                                  .arrow_back,
                              color:
                                  Colors
                                      .white,
                            ),
                            onPressed:
                                () =>
                                    Navigator.pop(
                                      context,
                                    ),
                          ),
                          const SizedBox(
                              width: 8),
                          const Text(
                            'Historial de Movimientos',
                            style:
                                TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  Colors
                                      .white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(
                    horizontal:
                        constraints.maxWidth >
                                600
                            ? (constraints
                                        .maxWidth -
                                    600) /
                                2
                            : 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      if (state.isLoading)
                        const Center(
                          child: Padding(
                            padding:
                                EdgeInsets.all(
                              40,
                            ),
                            child:
                                CircularProgressIndicator(),
                          ),
                        )
                      else ...[
                        const Text(
                          'Seleccionar Cuenta',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight
                                    .w600,
                            color: Color(
                              0xFF1A1A1A,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        AccountSelectorChip(
                          accounts:
                              state.accounts,
                          selectedAccount: state
                              .selectedAccount,
                          onSelect:
                              notifier
                                  .selectAccount,
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        SummaryCard(
                          income:
                              notifier
                                  .totalIncome,
                          expenses:
                              notifier
                                  .totalExpenses,
                          transfers:
                              notifier
                                  .totalTransfers,
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            const Text(
                              'Transacciones Recientes',
                              style:
                                  TextStyle(
                                fontSize:
                                    18,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color:
                                    Color(
                                  0xFF1A1A1A,
                                ),
                              ),
                            ),
                            if (state
                                .isLoadingTransactions)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth:
                                      2,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        if (state
                            .transactions
                            .isEmpty)
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                40,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons
                                        .receipt_long_outlined,
                                    size: 64,
                                    color: Colors
                                        .grey
                                        .shade400,
                                  ),
                                  const SizedBox(
                                    height:
                                        16,
                                  ),
                                  Text(
                                    'No hay transacciones',
                                    style:
                                        TextStyle(
                                      color: Colors
                                          .grey
                                          .shade600,
                                      fontSize:
                                          16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else ...[
                          ...state.transactions
                              .map(
                            (
                              transaction,
                            ) {
                              return TransactionListItem(
                                transaction:
                                    transaction,
                                onTap: () {
                                  notifier
                                      .selectTransaction(
                                    transaction,
                                  );

                                  _showDetailModal(
                                    context,
                                    ref,
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          if (state.hasMore)
                            Center(
                              child:
                                  ElevatedButton(
                                onPressed: state
                                        .isLoadingMore
                                    ? null
                                    : () {
                                        notifier
                                            .loadMoreTransactions();
                                      },
                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFF006FFD,
                                  ),
                                  foregroundColor:
                                      Colors
                                          .white,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        32,
                                    vertical:
                                        14,
                                  ),
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),
                                child: state
                                        .isLoadingMore
                                    ? const SizedBox(
                                        width:
                                            20,
                                        height:
                                            20,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth:
                                              2,
                                          color:
                                              Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Cargar más',
                                        style:
                                            TextStyle(
                                          fontSize:
                                              16,
                                          fontWeight:
                                              FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
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
  }

  void _showDetailModal(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state =
        ref.read(historyProvider);

    if (state.selectedTransaction ==
        null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent,
      builder:
          (context) =>
              TransactionDetailModal(
                transaction: state
                    .selectedTransaction!,
                onClose: () {
                  Navigator.pop(
                    context,
                  );

                  ref
                      .read(
                        historyProvider
                            .notifier,
                      )
                      .clearSelectedTransaction();
                },
              ),
    );
  }
}
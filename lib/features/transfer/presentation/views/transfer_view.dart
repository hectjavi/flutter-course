import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/transfer/presentation/states/transfer_notifier.dart';
import 'package:flutter_application_1/features/transfer/presentation/widgets/transfer_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferView extends ConsumerStatefulWidget {
  const TransferView({super.key});

  @override
  ConsumerState<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends ConsumerState<TransferView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(transferProvider.notifier).loadInitialData();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _tokenController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    final state = ref.read(transferProvider);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TransferSuccessDialog(
        amount: state.lastTransfer!.amount,
        destinationName:
            state.selectedDestinationAccount!.displayName,
        onClose: () {
          Navigator.of(context).pop();

          ref.read(transferProvider.notifier).resetTransfer();

          _amountController.clear();
          _tokenController.clear();
          _descriptionController.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferProvider);
    final notifier = ref.read(transferProvider.notifier);

    if (state.lastTransfer != null &&
        state.lastTransfer!.status == 'completed') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSuccessDialog();
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top:
                          MediaQuery.of(context).padding.top + 20,
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
                        colors: [
                          Color(0xFF006FFD),
                          Color(0xFF0051D4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Nueva Transferencia',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
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
                          CrossAxisAlignment.stretch,
                      children: [
                        if (state.isLoading)
                          const Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(40),
                              child:
                                  CircularProgressIndicator(),
                            ),
                          )
                        else ...[
                          if (state.error != null)
                            Container(
                              margin:
                                  const EdgeInsets.only(
                                bottom: 20,
                              ),
                              padding:
                                  const EdgeInsets.all(
                                16,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Colors.red.shade50,
                                borderRadius:
                                    BorderRadius
                                        .circular(12),
                                border: Border.all(
                                  color: Colors
                                      .red.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors
                                        .red.shade400,
                                  ),
                                  const SizedBox(
                                      width: 12),
                                  Expanded(
                                    child: Text(
                                      state.error!,
                                      style: TextStyle(
                                        color: Colors
                                            .red.shade700,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    onPressed:
                                        notifier
                                            .clearError,
                                  ),
                                ],
                              ),
                            ),

                          AccountSelectorWidget(
                            accounts:
                                state.sourceAccounts,
                            selectedAccount: state
                                .selectedSourceAccount,
                            onSelect: notifier
                                .selectSourceAccount,
                            title:
                                'Cuenta a Debitar',
                          ),

                          const SizedBox(height: 32),

                          DestinationSelectorWidget(
                            accounts: state
                                .destinationAccounts,
                            selectedAccount: state
                                .selectedDestinationAccount,
                            onSelect: notifier
                                .selectDestinationAccount,
                            onAddNew: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Función próximamente',
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),

                          AmountInputWidget(
                            controller:
                                _amountController,
                            errorText:
                                state.error
                                            ?.contains(
                                              'monto',
                                            ) ??
                                        false
                                    ? state.error
                                    : null,
                          ),

                          const SizedBox(height: 24),

                          TextField(
                            controller:
                                _descriptionController,
                            decoration:
                                InputDecoration(
                              labelText:
                                  'Descripción (opcional)',
                              hintText:
                                  'Ej: Pago de alquiler',
                              border:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(12),
                              ),
                            ),
                            maxLines: 2,
                          ),

                          const SizedBox(height: 32),

                          TokenInputWidget(
                            controller:
                                _tokenController,
                            tokenSent:
                                state.tokenSent,
                            isLoading:
                                state.isLoadingToken,
                            onRequestToken:
                                notifier.requestToken,
                            errorText:
                                state.tokenError,
                          ),

                          const SizedBox(height: 40),

                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed:
                                  state.isExecutingTransfer ||
                                          !notifier
                                              .canExecuteTransfer ||
                                          !state
                                              .tokenSent
                                      ? null
                                      : () async {
                                          final messenger =
                                              ScaffoldMessenger.of(
                                            context,
                                          );

                                          final amount =
                                              double.tryParse(
                                                    _amountController
                                                        .text,
                                                  ) ??
                                                  0;

                                          final success =
                                              await notifier
                                                  .executeTransfer(
                                            amount:
                                                amount,
                                            confirmationToken:
                                                _tokenController
                                                    .text,
                                            description:
                                                _descriptionController
                                                        .text
                                                        .isEmpty
                                                    ? null
                                                    : _descriptionController
                                                        .text,
                                          );

                                          if (!success &&
                                              mounted) {
                                            messenger
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(
                                                  ref
                                                          .read(
                                                            transferProvider,
                                                          )
                                                          .error ??
                                                      'Error en la transferencia',
                                                ),
                                                backgroundColor:
                                                    Colors.red,
                                              ),
                                            );
                                          }
                                        },
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFF006FFD,
                                ),
                                disabledBackgroundColor:
                                    Colors.grey
                                        .shade300,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    16,
                                  ),
                                ),
                              ),
                              child: state
                                      .isExecutingTransfer
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child:
                                          CircularProgressIndicator(
                                        color:
                                            Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Realizar Transferencia',
                                      style:
                                          TextStyle(
                                        color:
                                            Colors.white,
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Container(
                            padding:
                                const EdgeInsets.all(
                              16,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.amber.shade50,
                              borderRadius:
                                  BorderRadius
                                      .circular(12),
                              border: Border.all(
                                color: Colors
                                    .amber.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: Colors
                                      .amber.shade700,
                                ),
                                const SizedBox(
                                    width: 12),
                                Expanded(
                                  child: Text(
                                    'Esta transacción está protegida con verificación de doble factor.',
                                    style: TextStyle(
                                      color: Colors
                                          .amber.shade900,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/presentation/states/transfer_provider.dart';
import 'package:flutter_application_1/features/login/presentation/widgets/transfer_widgets.dart';
import 'package:provider/provider.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransferProvider()..loadInitialData(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF7F9FC),
        body: TransferBody(),
      ),
    );
  }
}

class TransferBody extends StatefulWidget {
  const TransferBody({super.key});

  @override
  State<TransferBody> createState() => _TransferBodyState();
}

class _TransferBodyState extends State<TransferBody> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _tokenController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(TransferProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TransferSuccessDialog(
        amount: provider.lastTransfer!.amount,
        destinationName: provider.selectedDestinationAccount!.displayName,
        onClose: () {
          Navigator.of(context).pop();
          provider.resetTransfer();
          _amountController.clear();
          _tokenController.clear();
          _descriptionController.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<TransferProvider>(
          builder: (context, provider, child) {
            // Mostrar diálogo de éxito si hay transferencia completada
            if (provider.lastTransfer != null && provider.lastTransfer!.status == 'completed') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showSuccessDialog(provider);
              });
            }

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
                                'Nueva Transferencia',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (provider.isLoading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else ...[
                            // Error general
                            if (provider.error != null)
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error, color: Colors.red.shade400),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        provider.error!,
                                        style: TextStyle(color: Colors.red.shade700),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 20),
                                      onPressed: provider.clearError,
                                    ),
                                  ],
                                ),
                              ),

                            // Selector de cuenta origen
                            AccountSelectorWidget(
                              accounts: provider.sourceAccounts,
                              selectedAccount: provider.selectedSourceAccount,
                              onSelect: provider.selectSourceAccount,
                              title: 'Cuenta a Debitar',
                            ),

                            const SizedBox(height: 32),

                            // Selector de cuenta destino
                            DestinationSelectorWidget(
                              accounts: provider.destinationAccounts,
                              selectedAccount: provider.selectedDestinationAccount,
                              onSelect: provider.selectDestinationAccount,
                              onAddNew: () {
                                // TODO: Implementar agregar nueva cuenta
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Función próximamente')),
                                );
                              },
                            ),

                            const SizedBox(height: 32),

                            // Monto
                            AmountInputWidget(
                              controller: _amountController,
                              errorText: provider.error?.contains('monto') ?? false ? provider.error : null,
                            ),

                            const SizedBox(height: 24),

                            // Descripción (opcional)
                            TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Descripción (opcional)',
                                hintText: 'Ej: Pago de alquiler',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 2,
                            ),

                            const SizedBox(height: 32),

                            // Token de confirmación
                            TokenInputWidget(
                              controller: _tokenController,
                              tokenSent: provider.tokenSent,
                              isLoading: provider.isLoadingToken,
                              onRequestToken: provider.requestToken,
                              errorText: provider.tokenError,
                            ),

                            const SizedBox(height: 40),

                            // Botón de transferencia
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: provider.isExecutingTransfer ||
                                        !provider.canExecuteTransfer ||
                                        !provider.tokenSent
                                    ? null
                                    : () async {
                                        final amount = double.tryParse(_amountController.text) ?? 0;
                                        final success = await provider.executeTransfer(
                                          amount: amount,
                                          confirmationToken: _tokenController.text,
                                          description: _descriptionController.text.isEmpty
                                              ? null
                                              : _descriptionController.text,
                                        );
                                        if (!success && mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(provider.error ?? 'Error en la transferencia'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF006FFD),
                                  disabledBackgroundColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  shadowColor: const Color(0xFF006FFD).withOpacity(0.4),
                                ),
                                child: provider.isExecutingTransfer
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Realizar Transferencia',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Nota de seguridad
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.amber.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.security, color: Colors.amber.shade700),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Esta transacción está protegida con verificación de doble factor.',
                                      style: TextStyle(
                                        color: Colors.amber.shade900,
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
        );
      },
    );
  }
}
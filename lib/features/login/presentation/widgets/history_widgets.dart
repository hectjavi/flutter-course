import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transaction_model.dart';
import 'package:intl/intl.dart';

class AccountSelectorChip extends StatelessWidget {
  final List<AccountModel> accounts;
  final AccountModel? selectedAccount;
  final Function(AccountModel) onSelect;

  const AccountSelectorChip({
    super.key,
    required this.accounts,
    required this.selectedAccount,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: accounts.map((account) {
          final isSelected = selectedAccount?.id == account.id;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              selected: isSelected,
              onSelected: (_) => onSelect(account),
              label: Text('${account.accountType} ${account.accountNumber}'),
              selectedColor: const Color(0xFF006FFD),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF006FFD) : Colors.grey.shade300,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('dd MMM, HH:mm');
    
    Color amountColor;
    IconData icon;
    Color iconBackground;

    switch (transaction.type) {
      case 'income':
        amountColor = const Color(0xFF00C853);
        icon = Icons.arrow_downward;
        iconBackground = Colors.green.shade50;
        break;
      case 'expense':
        amountColor = const Color(0xFFFF1744);
        icon = Icons.arrow_upward;
        iconBackground = Colors.red.shade50;
        break;
      case 'transfer':
        amountColor = const Color(0xFF006FFD);
        icon = Icons.swap_horiz;
        iconBackground = Colors.blue.shade50;
        break;
      default:
        amountColor = Colors.grey;
        icon = Icons.remove;
        iconBackground = Colors.grey.shade100;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: amountColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.counterpartyName ?? transaction.formattedType,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateFormat.format(transaction.date),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.isIncome ? '+' : '-'} ${currencyFormat.format(transaction.amount)}',
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: transaction.status == 'completed'
                        ? Colors.green.shade50
                        : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    transaction.status == 'completed' ? 'Completado' : 'Pendiente',
                    style: TextStyle(
                      color: transaction.status == 'completed'
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDetailModal extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onClose;

  const TransactionDetailModal({
    super.key,
    required this.transaction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy - HH:mm', 'es');

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icono grande
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIcon(),
                    color: _getColor(),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Monto
                Text(
                  currencyFormat.format(transaction.amount),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _getColor(),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Tipo
                Text(
                  transaction.formattedType,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Detalles
                _buildDetailRow('Descripción', transaction.description),
                _buildDetailRow('Fecha', dateFormat.format(transaction.date)),
                _buildDetailRow('Estado', transaction.status == 'completed' ? 'Completado' : 'Pendiente'),
                if (transaction.counterpartyName != null)
                  _buildDetailRow('Beneficiario', transaction.counterpartyName!),
                if (transaction.counterpartyAccount != null)
                  _buildDetailRow('Cuenta', transaction.counterpartyAccount!),
                if (transaction.referenceNumber != null)
                  _buildDetailRow('Referencia', transaction.referenceNumber!),
                if (transaction.category != null)
                  _buildDetailRow('Categoría', _capitalize(transaction.category!)),
                
                const SizedBox(height: 24),
                
                // Botón cerrar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onClose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006FFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (transaction.type) {
      case 'income':
        return const Color(0xFF00C853);
      case 'expense':
        return const Color(0xFFFF1744);
      case 'transfer':
        return const Color(0xFF006FFD);
      default:
        return Colors.grey;
    }
  }

  Color _getBackgroundColor() {
    switch (transaction.type) {
      case 'income':
        return Colors.green.shade50;
      case 'expense':
        return Colors.red.shade50;
      case 'transfer':
        return Colors.blue.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  IconData _getIcon() {
    switch (transaction.type) {
      case 'income':
        return Icons.arrow_downward;
      case 'expense':
        return Icons.arrow_upward;
      case 'transfer':
        return Icons.swap_horiz;
      default:
        return Icons.remove;
    }
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class SummaryCard extends StatelessWidget {
  final double income;
  final double expenses;
  final double transfers;

  const SummaryCard({
    super.key,
    required this.income,
    required this.expenses,
    required this.transfers,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF006FFD), Color(0xFF0051D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Ingresos', income, Colors.green.shade300),
          _buildDivider(),
          _buildSummaryItem('Gastos', expenses, Colors.red.shade300),
          _buildDivider(),
          _buildSummaryItem('Transferencias', transfers, Colors.white70),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currencyFormat.format(amount),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.2),
    );
  }
}
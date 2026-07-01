import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/features/history/data/models/account_model.dart';
import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<AccountModel> accounts,
    @Default([]) List<TransactionModel> transactions,

    AccountModel? selectedAccount,
    TransactionModel? selectedTransaction,

    @Default(false) bool isLoading,
    @Default(false) bool isLoadingTransactions,

    String? error,

    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? filterType,
  }) = _HistoryState;
}
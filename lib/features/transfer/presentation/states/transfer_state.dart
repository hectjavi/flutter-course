import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/transfer_model.dart';

part 'transfer_state.freezed.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState({
    @Default([]) List<AccountModel> sourceAccounts,
    @Default([]) List<AccountDestinationModel> destinationAccounts,

    AccountModel? selectedSourceAccount,
    AccountDestinationModel? selectedDestinationAccount,

    @Default(false) bool isLoading,
    @Default(false) bool isLoadingToken,
    @Default(false) bool isExecutingTransfer,

    String? error,
    String? tokenError,

    TransferModel? lastTransfer,

    @Default(false) bool tokenSent,
  }) = _TransferState;
}
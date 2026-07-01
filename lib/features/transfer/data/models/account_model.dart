import 'package:flutter_application_1/features/history/domain/entities/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String id,
    required String accountNumber,
    required String accountType,
    required double balance,
    required String currency,
    required String bankName,
    required String status,
  }) = _AccountModel;

  factory AccountModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AccountModelFromJson(json);

  factory AccountModel.fromEntity(
    Account account,
  ) {
    return AccountModel(
      id: account.id,
      accountNumber: account.accountNumber,
      accountType: account.accountType,
      balance: account.balance,
      currency: account.currency,
      bankName: account.bankName,
      status: account.status,
    );
  }

  Account toEntity() {
    return Account(
      id: id,
      accountNumber: accountNumber,
      accountType: accountType,
      balance: balance,
      currency: currency,
      bankName: bankName,
      status: status,
    );
  }
}
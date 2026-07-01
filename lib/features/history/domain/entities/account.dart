import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String accountNumber,
    required String accountType,
    required double balance,
    required String currency,
    required String bankName,
    required String status,
  }) = _Account;
}
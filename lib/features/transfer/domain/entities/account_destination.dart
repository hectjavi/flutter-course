import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_destination.freezed.dart';

@freezed
class AccountDestination with _$AccountDestination {
  const factory AccountDestination({
    required String id,
    required String accountNumber,
    required String accountHolderName,
    required String bankName,
    String? alias,
  }) = _AccountDestination;
}
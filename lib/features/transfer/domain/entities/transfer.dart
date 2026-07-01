import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    required String id,
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    required String currency,
    String? description,
    required String confirmationToken,
    required DateTime createdAt,
    required String status,
  }) = _Transfer;
}
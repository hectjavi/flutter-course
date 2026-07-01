import 'package:flutter_application_1/features/history/domain/entities/transfer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_model.freezed.dart';
part 'transfer_model.g.dart';

@freezed
class TransferModel with _$TransferModel {
  const TransferModel._();

  const factory TransferModel({
    required String id,
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    required String currency,
    String? description,
    required String confirmationToken,
    required DateTime createdAt,
    required String status,
  }) = _TransferModel;

  factory TransferModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TransferModelFromJson(json);

  factory TransferModel.fromEntity(
    Transfer transfer,
  ) {
    return TransferModel(
      id: transfer.id,
      sourceAccountId: transfer.sourceAccountId,
      destinationAccountId:
          transfer.destinationAccountId,
      amount: transfer.amount,
      currency: transfer.currency,
      description: transfer.description,
      confirmationToken:
          transfer.confirmationToken,
      createdAt: transfer.createdAt,
      status: transfer.status,
    );
  }

  Transfer toEntity() {
    return Transfer(
      id: id,
      sourceAccountId: sourceAccountId,
      destinationAccountId:
          destinationAccountId,
      amount: amount,
      currency: currency,
      description: description,
      confirmationToken:
          confirmationToken,
      createdAt: createdAt,
      status: status,
    );
  }
}
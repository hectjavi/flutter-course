import 'package:flutter_application_1/features/history/domain/entities/account_destination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_destination_model.freezed.dart';
part 'account_destination_model.g.dart';

@freezed
class AccountDestinationModel
    with _$AccountDestinationModel {
  const AccountDestinationModel._();

  const factory AccountDestinationModel({
    required String id,
    required String accountNumber,
    required String accountHolderName,
    required String bankName,
    String? alias,
  }) = _AccountDestinationModel;

  factory AccountDestinationModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AccountDestinationModelFromJson(json);

  factory AccountDestinationModel.fromEntity(
    AccountDestination destination,
  ) {
    return AccountDestinationModel(
      id: destination.id,
      accountNumber: destination.accountNumber,
      accountHolderName:
          destination.accountHolderName,
      bankName: destination.bankName,
      alias: destination.alias,
    );
  }

  AccountDestination toEntity() {
    return AccountDestination(
      id: id,
      accountNumber: accountNumber,
      accountHolderName:
          accountHolderName,
      bankName: bankName,
      alias: alias,
    );
  }

  String get displayName =>
      alias ?? accountHolderName;
}
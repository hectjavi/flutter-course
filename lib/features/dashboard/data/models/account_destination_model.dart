import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/account_destination.dart';

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
    AccountDestination entity,
  ) {
    return AccountDestinationModel(
      id: entity.id,
      accountNumber: entity.accountNumber,
      accountHolderName: entity.accountHolderName,
      bankName: entity.bankName,
      alias: entity.alias,
    );
  }

  AccountDestination toEntity() {
    return AccountDestination(
      id: id,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      bankName: bankName,
      alias: alias,
    );
  }

  String get displayName =>
      alias ?? accountHolderName;
}
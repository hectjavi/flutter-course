// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Transfer {
  String get id => throw _privateConstructorUsedError;
  String get sourceAccountId => throw _privateConstructorUsedError;
  String get destinationAccountId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get confirmationToken => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferCopyWith<Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCopyWith<$Res> {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) then) =
      _$TransferCopyWithImpl<$Res, Transfer>;
  @useResult
  $Res call({
    String id,
    String sourceAccountId,
    String destinationAccountId,
    double amount,
    String currency,
    String? description,
    String confirmationToken,
    DateTime createdAt,
    String status,
  });
}

/// @nodoc
class _$TransferCopyWithImpl<$Res, $Val extends Transfer>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceAccountId = null,
    Object? destinationAccountId = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
    Object? confirmationToken = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceAccountId: null == sourceAccountId
                ? _value.sourceAccountId
                : sourceAccountId // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationAccountId: null == destinationAccountId
                ? _value.destinationAccountId
                : destinationAccountId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            confirmationToken: null == confirmationToken
                ? _value.confirmationToken
                : confirmationToken // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransferImplCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory _$$TransferImplCopyWith(
    _$TransferImpl value,
    $Res Function(_$TransferImpl) then,
  ) = __$$TransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sourceAccountId,
    String destinationAccountId,
    double amount,
    String currency,
    String? description,
    String confirmationToken,
    DateTime createdAt,
    String status,
  });
}

/// @nodoc
class __$$TransferImplCopyWithImpl<$Res>
    extends _$TransferCopyWithImpl<$Res, _$TransferImpl>
    implements _$$TransferImplCopyWith<$Res> {
  __$$TransferImplCopyWithImpl(
    _$TransferImpl _value,
    $Res Function(_$TransferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceAccountId = null,
    Object? destinationAccountId = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
    Object? confirmationToken = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(
      _$TransferImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceAccountId: null == sourceAccountId
            ? _value.sourceAccountId
            : sourceAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationAccountId: null == destinationAccountId
            ? _value.destinationAccountId
            : destinationAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        confirmationToken: null == confirmationToken
            ? _value.confirmationToken
            : confirmationToken // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TransferImpl implements _Transfer {
  const _$TransferImpl({
    required this.id,
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.amount,
    required this.currency,
    this.description,
    required this.confirmationToken,
    required this.createdAt,
    required this.status,
  });

  @override
  final String id;
  @override
  final String sourceAccountId;
  @override
  final String destinationAccountId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String? description;
  @override
  final String confirmationToken;
  @override
  final DateTime createdAt;
  @override
  final String status;

  @override
  String toString() {
    return 'Transfer(id: $id, sourceAccountId: $sourceAccountId, destinationAccountId: $destinationAccountId, amount: $amount, currency: $currency, description: $description, confirmationToken: $confirmationToken, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceAccountId, sourceAccountId) ||
                other.sourceAccountId == sourceAccountId) &&
            (identical(other.destinationAccountId, destinationAccountId) ||
                other.destinationAccountId == destinationAccountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confirmationToken, confirmationToken) ||
                other.confirmationToken == confirmationToken) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sourceAccountId,
    destinationAccountId,
    amount,
    currency,
    description,
    confirmationToken,
    createdAt,
    status,
  );

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferImplCopyWith<_$TransferImpl> get copyWith =>
      __$$TransferImplCopyWithImpl<_$TransferImpl>(this, _$identity);
}

abstract class _Transfer implements Transfer {
  const factory _Transfer({
    required final String id,
    required final String sourceAccountId,
    required final String destinationAccountId,
    required final double amount,
    required final String currency,
    final String? description,
    required final String confirmationToken,
    required final DateTime createdAt,
    required final String status,
  }) = _$TransferImpl;

  @override
  String get id;
  @override
  String get sourceAccountId;
  @override
  String get destinationAccountId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String? get description;
  @override
  String get confirmationToken;
  @override
  DateTime get createdAt;
  @override
  String get status;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferImplCopyWith<_$TransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_destination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccountDestination {
  String get id => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get accountHolderName => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String? get alias => throw _privateConstructorUsedError;

  /// Create a copy of AccountDestination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountDestinationCopyWith<AccountDestination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDestinationCopyWith<$Res> {
  factory $AccountDestinationCopyWith(
    AccountDestination value,
    $Res Function(AccountDestination) then,
  ) = _$AccountDestinationCopyWithImpl<$Res, AccountDestination>;
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String accountHolderName,
    String bankName,
    String? alias,
  });
}

/// @nodoc
class _$AccountDestinationCopyWithImpl<$Res, $Val extends AccountDestination>
    implements $AccountDestinationCopyWith<$Res> {
  _$AccountDestinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountDestination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? accountHolderName = null,
    Object? bankName = null,
    Object? alias = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            accountHolderName: null == accountHolderName
                ? _value.accountHolderName
                : accountHolderName // ignore: cast_nullable_to_non_nullable
                      as String,
            bankName: null == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                      as String,
            alias: freezed == alias
                ? _value.alias
                : alias // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountDestinationImplCopyWith<$Res>
    implements $AccountDestinationCopyWith<$Res> {
  factory _$$AccountDestinationImplCopyWith(
    _$AccountDestinationImpl value,
    $Res Function(_$AccountDestinationImpl) then,
  ) = __$$AccountDestinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String accountHolderName,
    String bankName,
    String? alias,
  });
}

/// @nodoc
class __$$AccountDestinationImplCopyWithImpl<$Res>
    extends _$AccountDestinationCopyWithImpl<$Res, _$AccountDestinationImpl>
    implements _$$AccountDestinationImplCopyWith<$Res> {
  __$$AccountDestinationImplCopyWithImpl(
    _$AccountDestinationImpl _value,
    $Res Function(_$AccountDestinationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountDestination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? accountHolderName = null,
    Object? bankName = null,
    Object? alias = freezed,
  }) {
    return _then(
      _$AccountDestinationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountHolderName: null == accountHolderName
            ? _value.accountHolderName
            : accountHolderName // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: null == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        alias: freezed == alias
            ? _value.alias
            : alias // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AccountDestinationImpl implements _AccountDestination {
  const _$AccountDestinationImpl({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
    this.alias,
  });

  @override
  final String id;
  @override
  final String accountNumber;
  @override
  final String accountHolderName;
  @override
  final String bankName;
  @override
  final String? alias;

  @override
  String toString() {
    return 'AccountDestination(id: $id, accountNumber: $accountNumber, accountHolderName: $accountHolderName, bankName: $bankName, alias: $alias)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountDestinationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.alias, alias) || other.alias == alias));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountNumber,
    accountHolderName,
    bankName,
    alias,
  );

  /// Create a copy of AccountDestination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDestinationImplCopyWith<_$AccountDestinationImpl> get copyWith =>
      __$$AccountDestinationImplCopyWithImpl<_$AccountDestinationImpl>(
        this,
        _$identity,
      );
}

abstract class _AccountDestination implements AccountDestination {
  const factory _AccountDestination({
    required final String id,
    required final String accountNumber,
    required final String accountHolderName,
    required final String bankName,
    final String? alias,
  }) = _$AccountDestinationImpl;

  @override
  String get id;
  @override
  String get accountNumber;
  @override
  String get accountHolderName;
  @override
  String get bankName;
  @override
  String? get alias;

  /// Create a copy of AccountDestination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountDestinationImplCopyWith<_$AccountDestinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_destination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AccountDestinationModel _$AccountDestinationModelFromJson(
  Map<String, dynamic> json,
) {
  return _AccountDestinationModel.fromJson(json);
}

/// @nodoc
mixin _$AccountDestinationModel {
  String get id => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get accountHolderName => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String? get alias => throw _privateConstructorUsedError;

  /// Serializes this AccountDestinationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountDestinationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountDestinationModelCopyWith<AccountDestinationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDestinationModelCopyWith<$Res> {
  factory $AccountDestinationModelCopyWith(
    AccountDestinationModel value,
    $Res Function(AccountDestinationModel) then,
  ) = _$AccountDestinationModelCopyWithImpl<$Res, AccountDestinationModel>;
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
class _$AccountDestinationModelCopyWithImpl<
  $Res,
  $Val extends AccountDestinationModel
>
    implements $AccountDestinationModelCopyWith<$Res> {
  _$AccountDestinationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountDestinationModel
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
abstract class _$$AccountDestinationModelImplCopyWith<$Res>
    implements $AccountDestinationModelCopyWith<$Res> {
  factory _$$AccountDestinationModelImplCopyWith(
    _$AccountDestinationModelImpl value,
    $Res Function(_$AccountDestinationModelImpl) then,
  ) = __$$AccountDestinationModelImplCopyWithImpl<$Res>;
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
class __$$AccountDestinationModelImplCopyWithImpl<$Res>
    extends
        _$AccountDestinationModelCopyWithImpl<
          $Res,
          _$AccountDestinationModelImpl
        >
    implements _$$AccountDestinationModelImplCopyWith<$Res> {
  __$$AccountDestinationModelImplCopyWithImpl(
    _$AccountDestinationModelImpl _value,
    $Res Function(_$AccountDestinationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountDestinationModel
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
      _$AccountDestinationModelImpl(
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
@JsonSerializable()
class _$AccountDestinationModelImpl extends _AccountDestinationModel {
  const _$AccountDestinationModelImpl({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
    this.alias,
  }) : super._();

  factory _$AccountDestinationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountDestinationModelImplFromJson(json);

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
    return 'AccountDestinationModel(id: $id, accountNumber: $accountNumber, accountHolderName: $accountHolderName, bankName: $bankName, alias: $alias)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountDestinationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.alias, alias) || other.alias == alias));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountNumber,
    accountHolderName,
    bankName,
    alias,
  );

  /// Create a copy of AccountDestinationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDestinationModelImplCopyWith<_$AccountDestinationModelImpl>
  get copyWith =>
      __$$AccountDestinationModelImplCopyWithImpl<
        _$AccountDestinationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountDestinationModelImplToJson(this);
  }
}

abstract class _AccountDestinationModel extends AccountDestinationModel {
  const factory _AccountDestinationModel({
    required final String id,
    required final String accountNumber,
    required final String accountHolderName,
    required final String bankName,
    final String? alias,
  }) = _$AccountDestinationModelImpl;
  const _AccountDestinationModel._() : super._();

  factory _AccountDestinationModel.fromJson(Map<String, dynamic> json) =
      _$AccountDestinationModelImpl.fromJson;

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

  /// Create a copy of AccountDestinationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountDestinationModelImplCopyWith<_$AccountDestinationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

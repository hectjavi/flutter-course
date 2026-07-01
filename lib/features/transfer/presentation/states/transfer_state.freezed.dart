// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransferState {
  List<AccountModel> get sourceAccounts => throw _privateConstructorUsedError;
  List<AccountDestinationModel> get destinationAccounts =>
      throw _privateConstructorUsedError;
  AccountModel? get selectedSourceAccount => throw _privateConstructorUsedError;
  AccountDestinationModel? get selectedDestinationAccount =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingToken => throw _privateConstructorUsedError;
  bool get isExecutingTransfer => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get tokenError => throw _privateConstructorUsedError;
  TransferModel? get lastTransfer => throw _privateConstructorUsedError;
  bool get tokenSent => throw _privateConstructorUsedError;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferStateCopyWith<TransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
    TransferState value,
    $Res Function(TransferState) then,
  ) = _$TransferStateCopyWithImpl<$Res, TransferState>;
  @useResult
  $Res call({
    List<AccountModel> sourceAccounts,
    List<AccountDestinationModel> destinationAccounts,
    AccountModel? selectedSourceAccount,
    AccountDestinationModel? selectedDestinationAccount,
    bool isLoading,
    bool isLoadingToken,
    bool isExecutingTransfer,
    String? error,
    String? tokenError,
    TransferModel? lastTransfer,
    bool tokenSent,
  });

  $AccountModelCopyWith<$Res>? get selectedSourceAccount;
  $AccountDestinationModelCopyWith<$Res>? get selectedDestinationAccount;
  $TransferModelCopyWith<$Res>? get lastTransfer;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceAccounts = null,
    Object? destinationAccounts = null,
    Object? selectedSourceAccount = freezed,
    Object? selectedDestinationAccount = freezed,
    Object? isLoading = null,
    Object? isLoadingToken = null,
    Object? isExecutingTransfer = null,
    Object? error = freezed,
    Object? tokenError = freezed,
    Object? lastTransfer = freezed,
    Object? tokenSent = null,
  }) {
    return _then(
      _value.copyWith(
            sourceAccounts: null == sourceAccounts
                ? _value.sourceAccounts
                : sourceAccounts // ignore: cast_nullable_to_non_nullable
                      as List<AccountModel>,
            destinationAccounts: null == destinationAccounts
                ? _value.destinationAccounts
                : destinationAccounts // ignore: cast_nullable_to_non_nullable
                      as List<AccountDestinationModel>,
            selectedSourceAccount: freezed == selectedSourceAccount
                ? _value.selectedSourceAccount
                : selectedSourceAccount // ignore: cast_nullable_to_non_nullable
                      as AccountModel?,
            selectedDestinationAccount: freezed == selectedDestinationAccount
                ? _value.selectedDestinationAccount
                : selectedDestinationAccount // ignore: cast_nullable_to_non_nullable
                      as AccountDestinationModel?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingToken: null == isLoadingToken
                ? _value.isLoadingToken
                : isLoadingToken // ignore: cast_nullable_to_non_nullable
                      as bool,
            isExecutingTransfer: null == isExecutingTransfer
                ? _value.isExecutingTransfer
                : isExecutingTransfer // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokenError: freezed == tokenError
                ? _value.tokenError
                : tokenError // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastTransfer: freezed == lastTransfer
                ? _value.lastTransfer
                : lastTransfer // ignore: cast_nullable_to_non_nullable
                      as TransferModel?,
            tokenSent: null == tokenSent
                ? _value.tokenSent
                : tokenSent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get selectedSourceAccount {
    if (_value.selectedSourceAccount == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_value.selectedSourceAccount!, (value) {
      return _then(_value.copyWith(selectedSourceAccount: value) as $Val);
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountDestinationModelCopyWith<$Res>? get selectedDestinationAccount {
    if (_value.selectedDestinationAccount == null) {
      return null;
    }

    return $AccountDestinationModelCopyWith<$Res>(
      _value.selectedDestinationAccount!,
      (value) {
        return _then(
          _value.copyWith(selectedDestinationAccount: value) as $Val,
        );
      },
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferModelCopyWith<$Res>? get lastTransfer {
    if (_value.lastTransfer == null) {
      return null;
    }

    return $TransferModelCopyWith<$Res>(_value.lastTransfer!, (value) {
      return _then(_value.copyWith(lastTransfer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransferStateImplCopyWith<$Res>
    implements $TransferStateCopyWith<$Res> {
  factory _$$TransferStateImplCopyWith(
    _$TransferStateImpl value,
    $Res Function(_$TransferStateImpl) then,
  ) = __$$TransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AccountModel> sourceAccounts,
    List<AccountDestinationModel> destinationAccounts,
    AccountModel? selectedSourceAccount,
    AccountDestinationModel? selectedDestinationAccount,
    bool isLoading,
    bool isLoadingToken,
    bool isExecutingTransfer,
    String? error,
    String? tokenError,
    TransferModel? lastTransfer,
    bool tokenSent,
  });

  @override
  $AccountModelCopyWith<$Res>? get selectedSourceAccount;
  @override
  $AccountDestinationModelCopyWith<$Res>? get selectedDestinationAccount;
  @override
  $TransferModelCopyWith<$Res>? get lastTransfer;
}

/// @nodoc
class __$$TransferStateImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateImpl>
    implements _$$TransferStateImplCopyWith<$Res> {
  __$$TransferStateImplCopyWithImpl(
    _$TransferStateImpl _value,
    $Res Function(_$TransferStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceAccounts = null,
    Object? destinationAccounts = null,
    Object? selectedSourceAccount = freezed,
    Object? selectedDestinationAccount = freezed,
    Object? isLoading = null,
    Object? isLoadingToken = null,
    Object? isExecutingTransfer = null,
    Object? error = freezed,
    Object? tokenError = freezed,
    Object? lastTransfer = freezed,
    Object? tokenSent = null,
  }) {
    return _then(
      _$TransferStateImpl(
        sourceAccounts: null == sourceAccounts
            ? _value._sourceAccounts
            : sourceAccounts // ignore: cast_nullable_to_non_nullable
                  as List<AccountModel>,
        destinationAccounts: null == destinationAccounts
            ? _value._destinationAccounts
            : destinationAccounts // ignore: cast_nullable_to_non_nullable
                  as List<AccountDestinationModel>,
        selectedSourceAccount: freezed == selectedSourceAccount
            ? _value.selectedSourceAccount
            : selectedSourceAccount // ignore: cast_nullable_to_non_nullable
                  as AccountModel?,
        selectedDestinationAccount: freezed == selectedDestinationAccount
            ? _value.selectedDestinationAccount
            : selectedDestinationAccount // ignore: cast_nullable_to_non_nullable
                  as AccountDestinationModel?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingToken: null == isLoadingToken
            ? _value.isLoadingToken
            : isLoadingToken // ignore: cast_nullable_to_non_nullable
                  as bool,
        isExecutingTransfer: null == isExecutingTransfer
            ? _value.isExecutingTransfer
            : isExecutingTransfer // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenError: freezed == tokenError
            ? _value.tokenError
            : tokenError // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastTransfer: freezed == lastTransfer
            ? _value.lastTransfer
            : lastTransfer // ignore: cast_nullable_to_non_nullable
                  as TransferModel?,
        tokenSent: null == tokenSent
            ? _value.tokenSent
            : tokenSent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TransferStateImpl implements _TransferState {
  const _$TransferStateImpl({
    final List<AccountModel> sourceAccounts = const [],
    final List<AccountDestinationModel> destinationAccounts = const [],
    this.selectedSourceAccount,
    this.selectedDestinationAccount,
    this.isLoading = false,
    this.isLoadingToken = false,
    this.isExecutingTransfer = false,
    this.error,
    this.tokenError,
    this.lastTransfer,
    this.tokenSent = false,
  }) : _sourceAccounts = sourceAccounts,
       _destinationAccounts = destinationAccounts;

  final List<AccountModel> _sourceAccounts;
  @override
  @JsonKey()
  List<AccountModel> get sourceAccounts {
    if (_sourceAccounts is EqualUnmodifiableListView) return _sourceAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceAccounts);
  }

  final List<AccountDestinationModel> _destinationAccounts;
  @override
  @JsonKey()
  List<AccountDestinationModel> get destinationAccounts {
    if (_destinationAccounts is EqualUnmodifiableListView)
      return _destinationAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_destinationAccounts);
  }

  @override
  final AccountModel? selectedSourceAccount;
  @override
  final AccountDestinationModel? selectedDestinationAccount;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingToken;
  @override
  @JsonKey()
  final bool isExecutingTransfer;
  @override
  final String? error;
  @override
  final String? tokenError;
  @override
  final TransferModel? lastTransfer;
  @override
  @JsonKey()
  final bool tokenSent;

  @override
  String toString() {
    return 'TransferState(sourceAccounts: $sourceAccounts, destinationAccounts: $destinationAccounts, selectedSourceAccount: $selectedSourceAccount, selectedDestinationAccount: $selectedDestinationAccount, isLoading: $isLoading, isLoadingToken: $isLoadingToken, isExecutingTransfer: $isExecutingTransfer, error: $error, tokenError: $tokenError, lastTransfer: $lastTransfer, tokenSent: $tokenSent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateImpl &&
            const DeepCollectionEquality().equals(
              other._sourceAccounts,
              _sourceAccounts,
            ) &&
            const DeepCollectionEquality().equals(
              other._destinationAccounts,
              _destinationAccounts,
            ) &&
            (identical(other.selectedSourceAccount, selectedSourceAccount) ||
                other.selectedSourceAccount == selectedSourceAccount) &&
            (identical(
                  other.selectedDestinationAccount,
                  selectedDestinationAccount,
                ) ||
                other.selectedDestinationAccount ==
                    selectedDestinationAccount) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingToken, isLoadingToken) ||
                other.isLoadingToken == isLoadingToken) &&
            (identical(other.isExecutingTransfer, isExecutingTransfer) ||
                other.isExecutingTransfer == isExecutingTransfer) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.tokenError, tokenError) ||
                other.tokenError == tokenError) &&
            (identical(other.lastTransfer, lastTransfer) ||
                other.lastTransfer == lastTransfer) &&
            (identical(other.tokenSent, tokenSent) ||
                other.tokenSent == tokenSent));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sourceAccounts),
    const DeepCollectionEquality().hash(_destinationAccounts),
    selectedSourceAccount,
    selectedDestinationAccount,
    isLoading,
    isLoadingToken,
    isExecutingTransfer,
    error,
    tokenError,
    lastTransfer,
    tokenSent,
  );

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      __$$TransferStateImplCopyWithImpl<_$TransferStateImpl>(this, _$identity);
}

abstract class _TransferState implements TransferState {
  const factory _TransferState({
    final List<AccountModel> sourceAccounts,
    final List<AccountDestinationModel> destinationAccounts,
    final AccountModel? selectedSourceAccount,
    final AccountDestinationModel? selectedDestinationAccount,
    final bool isLoading,
    final bool isLoadingToken,
    final bool isExecutingTransfer,
    final String? error,
    final String? tokenError,
    final TransferModel? lastTransfer,
    final bool tokenSent,
  }) = _$TransferStateImpl;

  @override
  List<AccountModel> get sourceAccounts;
  @override
  List<AccountDestinationModel> get destinationAccounts;
  @override
  AccountModel? get selectedSourceAccount;
  @override
  AccountDestinationModel? get selectedDestinationAccount;
  @override
  bool get isLoading;
  @override
  bool get isLoadingToken;
  @override
  bool get isExecutingTransfer;
  @override
  String? get error;
  @override
  String? get tokenError;
  @override
  TransferModel? get lastTransfer;
  @override
  bool get tokenSent;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HistoryState {
  List<AccountModel> get accounts => throw _privateConstructorUsedError;
  List<TransactionModel> get transactions => throw _privateConstructorUsedError;
  AccountModel? get selectedAccount => throw _privateConstructorUsedError;
  TransactionModel? get selectedTransaction =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingTransactions => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get filterStartDate => throw _privateConstructorUsedError;
  DateTime? get filterEndDate => throw _privateConstructorUsedError;
  String? get filterType => throw _privateConstructorUsedError;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
    HistoryState value,
    $Res Function(HistoryState) then,
  ) = _$HistoryStateCopyWithImpl<$Res, HistoryState>;
  @useResult
  $Res call({
    List<AccountModel> accounts,
    List<TransactionModel> transactions,
    AccountModel? selectedAccount,
    TransactionModel? selectedTransaction,
    bool isLoading,
    bool isLoadingTransactions,
    String? error,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? filterType,
  });

  $AccountModelCopyWith<$Res>? get selectedAccount;
  $TransactionModelCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res, $Val extends HistoryState>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? transactions = null,
    Object? selectedAccount = freezed,
    Object? selectedTransaction = freezed,
    Object? isLoading = null,
    Object? isLoadingTransactions = null,
    Object? error = freezed,
    Object? filterStartDate = freezed,
    Object? filterEndDate = freezed,
    Object? filterType = freezed,
  }) {
    return _then(
      _value.copyWith(
            accounts: null == accounts
                ? _value.accounts
                : accounts // ignore: cast_nullable_to_non_nullable
                      as List<AccountModel>,
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<TransactionModel>,
            selectedAccount: freezed == selectedAccount
                ? _value.selectedAccount
                : selectedAccount // ignore: cast_nullable_to_non_nullable
                      as AccountModel?,
            selectedTransaction: freezed == selectedTransaction
                ? _value.selectedTransaction
                : selectedTransaction // ignore: cast_nullable_to_non_nullable
                      as TransactionModel?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingTransactions: null == isLoadingTransactions
                ? _value.isLoadingTransactions
                : isLoadingTransactions // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterStartDate: freezed == filterStartDate
                ? _value.filterStartDate
                : filterStartDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            filterEndDate: freezed == filterEndDate
                ? _value.filterEndDate
                : filterEndDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            filterType: freezed == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get selectedAccount {
    if (_value.selectedAccount == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_value.selectedAccount!, (value) {
      return _then(_value.copyWith(selectedAccount: value) as $Val);
    });
  }

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_value.selectedTransaction == null) {
      return null;
    }

    return $TransactionModelCopyWith<$Res>(_value.selectedTransaction!, (
      value,
    ) {
      return _then(_value.copyWith(selectedTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryStateImplCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory _$$HistoryStateImplCopyWith(
    _$HistoryStateImpl value,
    $Res Function(_$HistoryStateImpl) then,
  ) = __$$HistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AccountModel> accounts,
    List<TransactionModel> transactions,
    AccountModel? selectedAccount,
    TransactionModel? selectedTransaction,
    bool isLoading,
    bool isLoadingTransactions,
    String? error,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? filterType,
  });

  @override
  $AccountModelCopyWith<$Res>? get selectedAccount;
  @override
  $TransactionModelCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class __$$HistoryStateImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryStateImpl>
    implements _$$HistoryStateImplCopyWith<$Res> {
  __$$HistoryStateImplCopyWithImpl(
    _$HistoryStateImpl _value,
    $Res Function(_$HistoryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? transactions = null,
    Object? selectedAccount = freezed,
    Object? selectedTransaction = freezed,
    Object? isLoading = null,
    Object? isLoadingTransactions = null,
    Object? error = freezed,
    Object? filterStartDate = freezed,
    Object? filterEndDate = freezed,
    Object? filterType = freezed,
  }) {
    return _then(
      _$HistoryStateImpl(
        accounts: null == accounts
            ? _value._accounts
            : accounts // ignore: cast_nullable_to_non_nullable
                  as List<AccountModel>,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<TransactionModel>,
        selectedAccount: freezed == selectedAccount
            ? _value.selectedAccount
            : selectedAccount // ignore: cast_nullable_to_non_nullable
                  as AccountModel?,
        selectedTransaction: freezed == selectedTransaction
            ? _value.selectedTransaction
            : selectedTransaction // ignore: cast_nullable_to_non_nullable
                  as TransactionModel?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingTransactions: null == isLoadingTransactions
            ? _value.isLoadingTransactions
            : isLoadingTransactions // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterStartDate: freezed == filterStartDate
            ? _value.filterStartDate
            : filterStartDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        filterEndDate: freezed == filterEndDate
            ? _value.filterEndDate
            : filterEndDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        filterType: freezed == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HistoryStateImpl implements _HistoryState {
  const _$HistoryStateImpl({
    final List<AccountModel> accounts = const [],
    final List<TransactionModel> transactions = const [],
    this.selectedAccount,
    this.selectedTransaction,
    this.isLoading = false,
    this.isLoadingTransactions = false,
    this.error,
    this.filterStartDate,
    this.filterEndDate,
    this.filterType,
  }) : _accounts = accounts,
       _transactions = transactions;

  final List<AccountModel> _accounts;
  @override
  @JsonKey()
  List<AccountModel> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  final List<TransactionModel> _transactions;
  @override
  @JsonKey()
  List<TransactionModel> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final AccountModel? selectedAccount;
  @override
  final TransactionModel? selectedTransaction;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingTransactions;
  @override
  final String? error;
  @override
  final DateTime? filterStartDate;
  @override
  final DateTime? filterEndDate;
  @override
  final String? filterType;

  @override
  String toString() {
    return 'HistoryState(accounts: $accounts, transactions: $transactions, selectedAccount: $selectedAccount, selectedTransaction: $selectedTransaction, isLoading: $isLoading, isLoadingTransactions: $isLoadingTransactions, error: $error, filterStartDate: $filterStartDate, filterEndDate: $filterEndDate, filterType: $filterType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryStateImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            (identical(other.selectedAccount, selectedAccount) ||
                other.selectedAccount == selectedAccount) &&
            (identical(other.selectedTransaction, selectedTransaction) ||
                other.selectedTransaction == selectedTransaction) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingTransactions, isLoadingTransactions) ||
                other.isLoadingTransactions == isLoadingTransactions) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.filterStartDate, filterStartDate) ||
                other.filterStartDate == filterStartDate) &&
            (identical(other.filterEndDate, filterEndDate) ||
                other.filterEndDate == filterEndDate) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_accounts),
    const DeepCollectionEquality().hash(_transactions),
    selectedAccount,
    selectedTransaction,
    isLoading,
    isLoadingTransactions,
    error,
    filterStartDate,
    filterEndDate,
    filterType,
  );

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryStateImplCopyWith<_$HistoryStateImpl> get copyWith =>
      __$$HistoryStateImplCopyWithImpl<_$HistoryStateImpl>(this, _$identity);
}

abstract class _HistoryState implements HistoryState {
  const factory _HistoryState({
    final List<AccountModel> accounts,
    final List<TransactionModel> transactions,
    final AccountModel? selectedAccount,
    final TransactionModel? selectedTransaction,
    final bool isLoading,
    final bool isLoadingTransactions,
    final String? error,
    final DateTime? filterStartDate,
    final DateTime? filterEndDate,
    final String? filterType,
  }) = _$HistoryStateImpl;

  @override
  List<AccountModel> get accounts;
  @override
  List<TransactionModel> get transactions;
  @override
  AccountModel? get selectedAccount;
  @override
  TransactionModel? get selectedTransaction;
  @override
  bool get isLoading;
  @override
  bool get isLoadingTransactions;
  @override
  String? get error;
  @override
  DateTime? get filterStartDate;
  @override
  DateTime? get filterEndDate;
  @override
  String? get filterType;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryStateImplCopyWith<_$HistoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

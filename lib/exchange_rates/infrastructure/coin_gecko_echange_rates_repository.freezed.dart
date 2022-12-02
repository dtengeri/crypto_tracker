// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_gecko_echange_rates_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

_ExchangeRates _$_ExchangeRatesFromJson(Map<String, dynamic> json) {
  return __ExchangeRates.fromJson(json);
}

/// @nodoc
mixin _$_ExchangeRates {
  _CryptoRate get bitcoin => throw _privateConstructorUsedError;
  _CryptoRate get ethereum => throw _privateConstructorUsedError;
  _CryptoRate get dogecoin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ExchangeRatesCopyWith<_ExchangeRates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ExchangeRatesCopyWith<$Res> {
  factory _$ExchangeRatesCopyWith(
          _ExchangeRates value, $Res Function(_ExchangeRates) then) =
      __$ExchangeRatesCopyWithImpl<$Res, _ExchangeRates>;
  @useResult
  $Res call({_CryptoRate bitcoin, _CryptoRate ethereum, _CryptoRate dogecoin});

  _$CryptoRateCopyWith<$Res> get bitcoin;
  _$CryptoRateCopyWith<$Res> get ethereum;
  _$CryptoRateCopyWith<$Res> get dogecoin;
}

/// @nodoc
class __$ExchangeRatesCopyWithImpl<$Res, $Val extends _ExchangeRates>
    implements _$ExchangeRatesCopyWith<$Res> {
  __$ExchangeRatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bitcoin = null,
    Object? ethereum = null,
    Object? dogecoin = null,
  }) {
    return _then(_value.copyWith(
      bitcoin: null == bitcoin
          ? _value.bitcoin
          : bitcoin // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
      ethereum: null == ethereum
          ? _value.ethereum
          : ethereum // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
      dogecoin: null == dogecoin
          ? _value.dogecoin
          : dogecoin // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  _$CryptoRateCopyWith<$Res> get bitcoin {
    return _$CryptoRateCopyWith<$Res>(_value.bitcoin, (value) {
      return _then(_value.copyWith(bitcoin: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  _$CryptoRateCopyWith<$Res> get ethereum {
    return _$CryptoRateCopyWith<$Res>(_value.ethereum, (value) {
      return _then(_value.copyWith(ethereum: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  _$CryptoRateCopyWith<$Res> get dogecoin {
    return _$CryptoRateCopyWith<$Res>(_value.dogecoin, (value) {
      return _then(_value.copyWith(dogecoin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$__ExchangeRatesCopyWith<$Res>
    implements _$ExchangeRatesCopyWith<$Res> {
  factory _$$__ExchangeRatesCopyWith(
          _$__ExchangeRates value, $Res Function(_$__ExchangeRates) then) =
      __$$__ExchangeRatesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({_CryptoRate bitcoin, _CryptoRate ethereum, _CryptoRate dogecoin});

  @override
  _$CryptoRateCopyWith<$Res> get bitcoin;
  @override
  _$CryptoRateCopyWith<$Res> get ethereum;
  @override
  _$CryptoRateCopyWith<$Res> get dogecoin;
}

/// @nodoc
class __$$__ExchangeRatesCopyWithImpl<$Res>
    extends __$ExchangeRatesCopyWithImpl<$Res, _$__ExchangeRates>
    implements _$$__ExchangeRatesCopyWith<$Res> {
  __$$__ExchangeRatesCopyWithImpl(
      _$__ExchangeRates _value, $Res Function(_$__ExchangeRates) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bitcoin = null,
    Object? ethereum = null,
    Object? dogecoin = null,
  }) {
    return _then(_$__ExchangeRates(
      bitcoin: null == bitcoin
          ? _value.bitcoin
          : bitcoin // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
      ethereum: null == ethereum
          ? _value.ethereum
          : ethereum // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
      dogecoin: null == dogecoin
          ? _value.dogecoin
          : dogecoin // ignore: cast_nullable_to_non_nullable
              as _CryptoRate,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$__ExchangeRates implements __ExchangeRates {
  const _$__ExchangeRates(
      {required this.bitcoin, required this.ethereum, required this.dogecoin});

  factory _$__ExchangeRates.fromJson(Map<String, dynamic> json) =>
      _$$__ExchangeRatesFromJson(json);

  @override
  final _CryptoRate bitcoin;
  @override
  final _CryptoRate ethereum;
  @override
  final _CryptoRate dogecoin;

  @override
  String toString() {
    return '_ExchangeRates(bitcoin: $bitcoin, ethereum: $ethereum, dogecoin: $dogecoin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__ExchangeRates &&
            (identical(other.bitcoin, bitcoin) || other.bitcoin == bitcoin) &&
            (identical(other.ethereum, ethereum) ||
                other.ethereum == ethereum) &&
            (identical(other.dogecoin, dogecoin) ||
                other.dogecoin == dogecoin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bitcoin, ethereum, dogecoin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$__ExchangeRatesCopyWith<_$__ExchangeRates> get copyWith =>
      __$$__ExchangeRatesCopyWithImpl<_$__ExchangeRates>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$__ExchangeRatesToJson(
      this,
    );
  }
}

abstract class __ExchangeRates implements _ExchangeRates {
  const factory __ExchangeRates(
      {required final _CryptoRate bitcoin,
      required final _CryptoRate ethereum,
      required final _CryptoRate dogecoin}) = _$__ExchangeRates;

  factory __ExchangeRates.fromJson(Map<String, dynamic> json) =
      _$__ExchangeRates.fromJson;

  @override
  _CryptoRate get bitcoin;
  @override
  _CryptoRate get ethereum;
  @override
  _CryptoRate get dogecoin;
  @override
  @JsonKey(ignore: true)
  _$$__ExchangeRatesCopyWith<_$__ExchangeRates> get copyWith =>
      throw _privateConstructorUsedError;
}

_CryptoRate _$_CryptoRateFromJson(Map<String, dynamic> json) {
  return __CryptoRate.fromJson(json);
}

/// @nodoc
mixin _$_CryptoRate {
  double get usd => throw _privateConstructorUsedError;
  @JsonKey(name: 'usd_24h_change')
  double get usd24Change => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$CryptoRateCopyWith<_CryptoRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CryptoRateCopyWith<$Res> {
  factory _$CryptoRateCopyWith(
          _CryptoRate value, $Res Function(_CryptoRate) then) =
      __$CryptoRateCopyWithImpl<$Res, _CryptoRate>;
  @useResult
  $Res call({double usd, @JsonKey(name: 'usd_24h_change') double usd24Change});
}

/// @nodoc
class __$CryptoRateCopyWithImpl<$Res, $Val extends _CryptoRate>
    implements _$CryptoRateCopyWith<$Res> {
  __$CryptoRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usd = null,
    Object? usd24Change = null,
  }) {
    return _then(_value.copyWith(
      usd: null == usd
          ? _value.usd
          : usd // ignore: cast_nullable_to_non_nullable
              as double,
      usd24Change: null == usd24Change
          ? _value.usd24Change
          : usd24Change // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$__CryptoRateCopyWith<$Res>
    implements _$CryptoRateCopyWith<$Res> {
  factory _$$__CryptoRateCopyWith(
          _$__CryptoRate value, $Res Function(_$__CryptoRate) then) =
      __$$__CryptoRateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double usd, @JsonKey(name: 'usd_24h_change') double usd24Change});
}

/// @nodoc
class __$$__CryptoRateCopyWithImpl<$Res>
    extends __$CryptoRateCopyWithImpl<$Res, _$__CryptoRate>
    implements _$$__CryptoRateCopyWith<$Res> {
  __$$__CryptoRateCopyWithImpl(
      _$__CryptoRate _value, $Res Function(_$__CryptoRate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usd = null,
    Object? usd24Change = null,
  }) {
    return _then(_$__CryptoRate(
      usd: null == usd
          ? _value.usd
          : usd // ignore: cast_nullable_to_non_nullable
              as double,
      usd24Change: null == usd24Change
          ? _value.usd24Change
          : usd24Change // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$__CryptoRate implements __CryptoRate {
  const _$__CryptoRate(
      {required this.usd,
      @JsonKey(name: 'usd_24h_change') required this.usd24Change});

  factory _$__CryptoRate.fromJson(Map<String, dynamic> json) =>
      _$$__CryptoRateFromJson(json);

  @override
  final double usd;
  @override
  @JsonKey(name: 'usd_24h_change')
  final double usd24Change;

  @override
  String toString() {
    return '_CryptoRate(usd: $usd, usd24Change: $usd24Change)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__CryptoRate &&
            (identical(other.usd, usd) || other.usd == usd) &&
            (identical(other.usd24Change, usd24Change) ||
                other.usd24Change == usd24Change));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, usd, usd24Change);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$__CryptoRateCopyWith<_$__CryptoRate> get copyWith =>
      __$$__CryptoRateCopyWithImpl<_$__CryptoRate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$__CryptoRateToJson(
      this,
    );
  }
}

abstract class __CryptoRate implements _CryptoRate {
  const factory __CryptoRate(
          {required final double usd,
          @JsonKey(name: 'usd_24h_change') required final double usd24Change}) =
      _$__CryptoRate;

  factory __CryptoRate.fromJson(Map<String, dynamic> json) =
      _$__CryptoRate.fromJson;

  @override
  double get usd;
  @override
  @JsonKey(name: 'usd_24h_change')
  double get usd24Change;
  @override
  @JsonKey(ignore: true)
  _$$__CryptoRateCopyWith<_$__CryptoRate> get copyWith =>
      throw _privateConstructorUsedError;
}

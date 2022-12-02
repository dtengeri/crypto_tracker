// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_gecko_echange_rates_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$__ExchangeRates _$$__ExchangeRatesFromJson(Map<String, dynamic> json) =>
    _$__ExchangeRates(
      bitcoin: _CryptoRate.fromJson(json['bitcoin'] as Map<String, dynamic>),
      ethereum: _CryptoRate.fromJson(json['ethereum'] as Map<String, dynamic>),
      dogecoin: _CryptoRate.fromJson(json['dogecoin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$__ExchangeRatesToJson(_$__ExchangeRates instance) =>
    <String, dynamic>{
      'bitcoin': instance.bitcoin.toJson(),
      'ethereum': instance.ethereum.toJson(),
      'dogecoin': instance.dogecoin.toJson(),
    };

_$__CryptoRate _$$__CryptoRateFromJson(Map<String, dynamic> json) =>
    _$__CryptoRate(
      usd: (json['usd'] as num).toDouble(),
      usd24Change: (json['usd_24h_change'] as num).toDouble(),
    );

Map<String, dynamic> _$$__CryptoRateToJson(_$__CryptoRate instance) =>
    <String, dynamic>{
      'usd': instance.usd,
      'usd_24h_change': instance.usd24Change,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class __CoinGeckoApi implements _CoinGeckoApi {
  __CoinGeckoApi(this._dio) {
    baseUrl ??= 'https://api.coingecko.com/api/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<_ExchangeRates> loadExchangeRates() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<_ExchangeRates>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/simple/price?ids=bitcoin%2Cethereum%2Cdogecoin&vs_currencies=usd&include_24hr_change=true',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _ExchangeRates.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

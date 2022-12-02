// ignore_for_file: invalid_annotation_target

import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'coin_gecko_echange_rates_repository.freezed.dart';
part 'coin_gecko_echange_rates_repository.g.dart';

@Injectable(as: ExchangeRatesRepository, env: ['prod'])
class CoinGeckoExchangeRatesReporitory extends ExchangeRatesRepository {
  CoinGeckoExchangeRatesReporitory({
    required this.dio,
  });
  final Dio dio;

  late final _CoinGeckoApi _coinGeckoApi = _CoinGeckoApi(dio);

  @override
  Future<Map<String, ExchangeRate>> loadExchangeRates() async {
    final exchangeRates = await _coinGeckoApi.loadExchangeRates();
    return {
      'BTC': ExchangeRate(
        baseCurrency: 'BTC',
        targetCurrency: 'USD',
        rate: exchangeRates.bitcoin.usd,
        changeInLast24Hours: exchangeRates.bitcoin.usd24Change,
      ),
      'ETH': ExchangeRate(
        baseCurrency: 'ETH',
        targetCurrency: 'USD',
        rate: exchangeRates.ethereum.usd,
        changeInLast24Hours: exchangeRates.ethereum.usd24Change,
      ),
      'DOGE': ExchangeRate(
        baseCurrency: 'DOGE',
        targetCurrency: 'USD',
        rate: exchangeRates.dogecoin.usd,
        changeInLast24Hours: exchangeRates.dogecoin.usd24Change,
      ),
    };
  }
}

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class _CoinGeckoApi {
  factory _CoinGeckoApi(Dio dio) = __CoinGeckoApi;

  @GET(
      '/simple/price?ids=bitcoin%2Cethereum%2Cdogecoin&vs_currencies=usd&include_24hr_change=true')
  Future<_ExchangeRates> loadExchangeRates();
}

@freezed
class _ExchangeRates with _$_ExchangeRates {
  const factory _ExchangeRates({
    required _CryptoRate bitcoin,
    required _CryptoRate ethereum,
    required _CryptoRate dogecoin,
  }) = __ExchangeRates;

  factory _ExchangeRates.fromJson(Map<String, dynamic> json) =>
      _$_ExchangeRatesFromJson(json);
}

@freezed
class _CryptoRate with _$_CryptoRate {
  const factory _CryptoRate({
    required double usd,
    @JsonKey(name: 'usd_24h_change') required double usd24Change,
  }) = __CryptoRate;

  factory _CryptoRate.fromJson(Map<String, dynamic> json) =>
      _$_CryptoRateFromJson(json);
}

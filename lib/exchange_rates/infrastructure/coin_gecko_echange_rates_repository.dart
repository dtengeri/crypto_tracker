// ignore_for_file: invalid_annotation_target

import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:dio/dio.dart';

const _exchangeRatesUrl =
    'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Cdogecoin&vs_currencies=usd&include_24hr_change=true';

class CoinGeckoExchangeRatesReporitory extends ExchangeRatesRepository {
  CoinGeckoExchangeRatesReporitory({
    required this.dio,
  });
  final Dio dio;

  @override
  Future<Map<String, ExchangeRate>> loadExchangeRates() async {
    try {
      final response = await dio.get(
        _exchangeRatesUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode != 200) {
        return {};
      }
      final data = response.data;
      return {
        'BTC': ExchangeRate(
          baseCurrency: 'BTC',
          targetCurrency: 'USD',
          rate: data['bitcoin']?['usd'] ?? 0,
          changeInLast24Hours: data['bitcoin']?['usd_24h_change'] ?? 0,
        ),
        'ETH': ExchangeRate(
          baseCurrency: 'ETH',
          targetCurrency: 'USD',
          rate: data['ethereum']?['usd'] ?? 0,
          changeInLast24Hours: data['ethereum']?['usd_24h_change'] ?? 0,
        ),
        'DOGE': ExchangeRate(
          baseCurrency: 'DOGE',
          targetCurrency: 'USD',
          rate: data['dogecoin']?['usd'] ?? 0,
          changeInLast24Hours: data['dogecoin']?['usd_24h_change'] ?? 0,
        ),
      };
    } catch (e) {
      return {};
    }
  }
}

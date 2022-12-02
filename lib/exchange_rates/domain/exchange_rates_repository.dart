import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';

abstract class ExchangeRatesRepository {
  Future<Map<String, ExchangeRate>> loadExchangeRates();
}

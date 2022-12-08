import 'package:exchange_rates/src/domain/domain.dart';

abstract class ExchangeRatesRepository {
  Future<Map<String, ExchangeRate>> loadExchangeRates();
}

part of 'exchange_rates_list_cubit.dart';

@freezed
class ExchangeRatesListState with _$ExchangeRatesListState {
  const factory ExchangeRatesListState.initial() = _Initial;
  const factory ExchangeRatesListState.loading() = _Loading;
  const factory ExchangeRatesListState.failure() = _Failure;
  const factory ExchangeRatesListState.loaded(
    Map<String, ExchangeRate> exchangeRates,
  ) = _Loaded;
}

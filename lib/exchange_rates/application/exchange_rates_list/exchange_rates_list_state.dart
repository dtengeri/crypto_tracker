part of 'exchange_rates_list_cubit.dart';

class ExchangeRatesListState extends Equatable {
  const ExchangeRatesListState({
    required this.exchangeRates,
    required this.areExhangeRatesLoaded,
    required this.areExhangeRatesLoading,
  });

  const ExchangeRatesListState.initial()
      : this(
          exchangeRates: const {},
          areExhangeRatesLoaded: false,
          areExhangeRatesLoading: false,
        );

  final Map<String, ExchangeRate> exchangeRates;
  final bool areExhangeRatesLoaded;
  final bool areExhangeRatesLoading;

  ExchangeRatesListState copyWith({
    Map<String, ExchangeRate>? exchangeRates,
    bool? areExhangeRatesLoaded,
    bool? areExhangeRatesLoading,
  }) =>
      ExchangeRatesListState(
        areExhangeRatesLoaded:
            areExhangeRatesLoaded ?? this.areExhangeRatesLoaded,
        areExhangeRatesLoading:
            areExhangeRatesLoading ?? this.areExhangeRatesLoading,
        exchangeRates: exchangeRates ?? this.exchangeRates,
      );

  @override
  List<Object?> get props => [
        exchangeRates,
        areExhangeRatesLoading,
        areExhangeRatesLoaded,
      ];
}

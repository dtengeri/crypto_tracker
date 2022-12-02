part of 'crypto_tracker_cubit.dart';

class CryptoTrackerState extends Equatable {
  const CryptoTrackerState({
    required this.exchangeRates,
    required this.areExhangeRatesLoaded,
    required this.areExhangeRatesLoading,
    required this.accounts,
    required this.areAccountsLoading,
    required this.areAccountsLoaded,
  });

  const CryptoTrackerState.initial()
      : this(
          exchangeRates: const {},
          areExhangeRatesLoaded: false,
          areExhangeRatesLoading: false,
          accounts: const [],
          areAccountsLoading: false,
          areAccountsLoaded: false,
        );

  final Map<String, ExchangeRate> exchangeRates;
  final bool areExhangeRatesLoaded;
  final bool areExhangeRatesLoading;
  final List<Account> accounts;
  final bool areAccountsLoading;
  final bool areAccountsLoaded;

  CryptoTrackerState copyWith({
    Map<String, ExchangeRate>? exchangeRates,
    bool? areExhangeRatesLoaded,
    bool? areExhangeRatesLoading,
    List<Account>? accounts,
    bool? areAccountsLoading,
    bool? areAccountsLoaded,
  }) =>
      CryptoTrackerState(
        areExhangeRatesLoaded:
            areExhangeRatesLoaded ?? this.areExhangeRatesLoaded,
        areExhangeRatesLoading:
            areExhangeRatesLoading ?? this.areExhangeRatesLoading,
        exchangeRates: exchangeRates ?? this.exchangeRates,
        accounts: accounts ?? this.accounts,
        areAccountsLoading: areAccountsLoading ?? this.areAccountsLoading,
        areAccountsLoaded: areAccountsLoaded ?? this.areAccountsLoaded,
      );

  @override
  List<Object?> get props => [
        exchangeRates,
        areExhangeRatesLoading,
        areExhangeRatesLoaded,
        accounts,
        areAccountsLoading,
        areAccountsLoaded,
      ];
}

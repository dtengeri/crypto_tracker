import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/models/account.dart';
import 'package:crypto_tracker/models/exhcange_rate.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'crypto_tracker_state.dart';

class CryptoTrackerCubit extends Cubit<CryptoTrackerState> {
  CryptoTrackerCubit() : super(const CryptoTrackerState.initial());

  Future<void> loadExchangeRates() async {
    emit(state.copyWith(
      areExhangeRatesLoading: true,
    ));
    final dio = Dio();
    final response = await dio.get(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Cdogecoin&vs_currencies=usd&include_24hr_change=true',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode != 200) {
      emit(state.copyWith(
        areExhangeRatesLoading: false,
      ));
      return;
    }
    final data = response.data;
    final exchangeRates = {
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
    emit(
      state.copyWith(
        exchangeRates: exchangeRates,
        areExhangeRatesLoaded: true,
        areExhangeRatesLoading: false,
      ),
    );
  }

  void loadAccounts() {
    emit(state.copyWith(areAccountsLoading: true));
    final accounts = Hive.box<Account>('accounts').values.toList();
    emit(state.copyWith(
      accounts: accounts,
      areAccountsLoaded: true,
      areAccountsLoading: false,
    ));
  }

  Future<void> addAccount(Account account) async {
    await Hive.box<Account>('accounts').put(account.coin, account);
    loadAccounts();
  }

  Future<void> updateAccount(Account account) async {
    await Hive.box<Account>('accounts').put(account.coin, account);
    loadAccounts();
  }
}

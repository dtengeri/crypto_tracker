import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rates_list_cubit.freezed.dart';
part 'exchange_rates_list_state.dart';

class ExchangeRatesListCubit extends Cubit<ExchangeRatesListState> {
  ExchangeRatesListCubit() : super(const ExchangeRatesListState.initial());

  Future<void> loadExchangeRates() async {
    emit(const ExchangeRatesListState.loading());
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
      emit(const ExchangeRatesListState.failure());
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
    emit(ExchangeRatesListState.loaded(exchangeRates));
  }
}

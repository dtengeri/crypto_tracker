import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rates_list_cubit.freezed.dart';
part 'exchange_rates_list_state.dart';

class ExchangeRatesListCubit extends Cubit<ExchangeRatesListState> {
  ExchangeRatesListCubit({
    required this.exchangeRatesRepository,
  }) : super(const ExchangeRatesListState.initial());

  final ExchangeRatesRepository exchangeRatesRepository;

  Future<void> loadExchangeRates() async {
    emit(const ExchangeRatesListState.loading());
    final exchangeRates = await exchangeRatesRepository.loadExchangeRates();
    emit(ExchangeRatesListState.loaded(exchangeRates));
  }
}

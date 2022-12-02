// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_tracker/exchange_rates/application/exchange_rates_list/exchange_rates_list_cubit.dart'
    as _i6;
import 'package:crypto_tracker/exchange_rates/exchange_rates.dart' as _i4;
import 'package:crypto_tracker/exchange_rates/infrastructure/coin_gecko_echange_rates_repository.dart'
    as _i5;
import 'package:crypto_tracker/get_it.dart' as _i7;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.Dio>(registerModule.dio());
  gh.factory<_i4.ExchangeRatesRepository>(
    () => _i5.CoinGeckoExchangeRatesReporitory(dio: gh<_i3.Dio>()),
    registerFor: {_prod},
  );
  gh.factory<_i6.ExchangeRatesListCubit>(() => _i6.ExchangeRatesListCubit(
      exchangeRatesRepository: gh<_i4.ExchangeRatesRepository>()));
  return getIt;
}

class _$RegisterModule extends _i7.RegisterModule {}

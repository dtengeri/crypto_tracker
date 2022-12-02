import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'get_it.config.dart';

final getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio();
}

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt, environment: 'prod');

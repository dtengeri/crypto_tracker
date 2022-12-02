import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:crypto_tracker/get_it.dart';
import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  await Hive.openBox<Account>('accounts');
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crypto Tracker',
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ExchangeRatesListCubit>()..loadExchangeRates(),
        ),
        BlocProvider(
          create: (context) => PortfolioListCubit()..loadAccounts(),
        ),
        BlocProvider(
          create: (context) => PortfolioActorCubit(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              ExchangeRates(),
              Expanded(
                child: Portfolio(),
              ),
              Text('Data provided by CoinGecko'),
            ],
          ),
        ),
      ),
    );
  }
}

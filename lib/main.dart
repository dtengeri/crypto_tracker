import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:dio/dio.dart';
import 'package:exchange_rates/exchange_rates.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await HiveAccountRepository.init();
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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final CoinGeckoExchangeRatesReporitory _exchangeRatesRepository =
      CoinGeckoExchangeRatesReporitory(
    dio: Dio(),
  );
  late final AccountRepository _accountRepository = HiveAccountRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ExchangeRates(),
            Expanded(
              child: Portfolio(
                accountRepository: _accountRepository,
                exchangeRatesRepository: _exchangeRatesRepository,
              ),
            ),
            const Text('Data provided by CoinGecko'),
          ],
        ),
      ),
    );
  }
}

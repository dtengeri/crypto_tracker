import 'package:crypto_tracker/bloc/crypto_tracker_cubit.dart';
import 'package:crypto_tracker/models/account.dart';
import 'package:crypto_tracker/models/exhcange_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  await Hive.openBox<Account>('accounts');
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
    return BlocProvider(
      create: (context) => CryptoTrackerCubit()
        ..loadAccounts()
        ..loadExchangeRates(),
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

class ExchangeRates extends StatelessWidget {
  const ExchangeRates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoTrackerCubit, CryptoTrackerState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Exchange Rates',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CryptoTrackerCubit>().loadExchangeRates();
                  },
                  icon: const Icon(Icons.refresh),
                ),
                if (state.areExhangeRatesLoading)
                  const CircularProgressIndicator(),
              ],
            ),
            if (state.areExhangeRatesLoaded)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.exchangeRates.values
                    .map(
                      (exchangeRate) => SizedBox(
                        width: 120,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        exchangeRate.baseCurrency,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    Icon(
                                      exchangeRate.changeInLast24Hours < 0
                                          ? Icons.trending_down
                                          : Icons.trending_up,
                                      color:
                                          exchangeRate.changeInLast24Hours < 0
                                              ? Colors.red
                                              : Colors.green,
                                    ),
                                  ],
                                ),
                                Text('\$${exchangeRate.rate}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
          ],
        );
      },
    );
  }
}

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final TextEditingController _addAccountTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _addAccountTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoTrackerCubit, CryptoTrackerState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  'Portfolio',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              if (state.areAccountsLoaded)
                IconButton(
                  onPressed: () async {
                    final cryptoTrackerCubit =
                        context.read<CryptoTrackerCubit>();
                    _addAccountTextEditingController.clear();
                    final coin = await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Add new account'),
                        content: TextField(
                          controller: _addAccountTextEditingController,
                          decoration: const InputDecoration(
                            label: Text('Coin'),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(_addAccountTextEditingController.text);
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    );
                    if (coin != null && coin.isNotEmpty) {
                      cryptoTrackerCubit
                          .addAccount(Account(coin: coin, balance: 0));
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              IconButton(
                onPressed: () {
                  context.read<CryptoTrackerCubit>().loadAccounts();
                },
                icon: const Icon(Icons.refresh),
              ),
              if (state.areAccountsLoading) const CircularProgressIndicator(),
            ],
          ),
          if (state.areAccountsLoaded)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.accounts.length,
                  itemBuilder: (context, index) => PortfolioItem(
                    account: state.accounts[index],
                    exchangeRate:
                        state.exchangeRates[state.accounts[index].coin],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

class PortfolioItem extends StatefulWidget {
  const PortfolioItem({
    super.key,
    required this.account,
    this.exchangeRate,
  });

  final Account account;
  final ExchangeRate? exchangeRate;

  @override
  State<PortfolioItem> createState() => _PortfolioItemState();
}

class _PortfolioItemState extends State<PortfolioItem> {
  final TextEditingController _balanceTextEditingController =
      TextEditingController();

  double? _valueInUsd;

  void _setValueInUsd() {
    if (widget.exchangeRate != null) {
      setState(() {
        _valueInUsd =
            (double.tryParse(_balanceTextEditingController.text) ?? 0) *
                widget.exchangeRate!.rate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _balanceTextEditingController.text = widget.account.balance.toString();
    _balanceTextEditingController.addListener(_setValueInUsd);
    _setValueInUsd();
  }

  @override
  void didUpdateWidget(covariant PortfolioItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.account != widget.account) {
      _balanceTextEditingController.text = widget.account.balance.toString();
    }
    if (oldWidget.exchangeRate != widget.exchangeRate) {
      _setValueInUsd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _balanceTextEditingController,
            decoration: const InputDecoration(
              label: Text('Balance'),
            ),
          ),
        ),
        Text(widget.account.coin),
        Expanded(
            child: Text(
          '\$${_valueInUsd ?? ''}',
          textAlign: TextAlign.right,
        )),
        IconButton(
          onPressed: () {
            context.read<CryptoTrackerCubit>().updateAccount(
                  Account(
                    coin: widget.account.coin,
                    balance:
                        double.tryParse(_balanceTextEditingController.text) ??
                            0,
                  ),
                );
          },
          icon: const Icon(
            Icons.save,
          ),
        )
      ],
    );
  }
}

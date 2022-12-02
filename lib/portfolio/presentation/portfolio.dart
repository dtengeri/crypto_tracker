import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<PortfolioListCubit, PortfolioListState>(
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
                        context.read<PortfolioActorCubit>();
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
                  context.read<PortfolioListCubit>().loadAccounts();
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
                  itemBuilder: (context, index) => BlocBuilder<
                      ExchangeRatesListCubit, ExchangeRatesListState>(
                    builder: (context, exhangeRatesState) {
                      return PortfolioItem(
                        account: state.accounts[index],
                        exchangeRate: exhangeRatesState
                            .exchangeRates[state.accounts[index].coin],
                      );
                    },
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
            context.read<PortfolioActorCubit>().updateAccount(
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

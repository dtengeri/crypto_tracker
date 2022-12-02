import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRates extends StatelessWidget {
  const ExchangeRates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRatesListCubit, ExchangeRatesListState>(
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
                    context.read<ExchangeRatesListCubit>().loadExchangeRates();
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

import 'package:crypto_tracker/core/core.dart';
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
          children: const [
            SectionHeader(
              title: 'Exchange Rates',
              actions: [
                _RefreshExchangeRatesButton(),
                _ExhangeRatesLoadingIndicator()
              ],
            ),
            _ExhangeRatesGrid(),
          ],
        );
      },
    );
  }
}

class _RefreshExchangeRatesButton extends StatelessWidget {
  const _RefreshExchangeRatesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ExchangeRatesListCubit>().loadExchangeRates();
      },
      icon: const Icon(Icons.refresh),
    );
  }
}

class _ExhangeRatesLoadingIndicator extends StatelessWidget {
  const _ExhangeRatesLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRatesListCubit, ExchangeRatesListState>(
      builder: (context, state) => state.maybeWhen(
        loading: () => const CircularProgressIndicator(),
        orElse: () => const SizedBox(),
      ),
    );
  }
}

class _ExhangeRatesGrid extends StatelessWidget {
  const _ExhangeRatesGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRatesListCubit, ExchangeRatesListState>(
      builder: (context, state) => state.maybeWhen(
        orElse: () => const SizedBox(),
        loaded: (exchangeRates) => _ExchangeRatesRow(
          exchangeRates: exchangeRates,
        ),
      ),
    );
  }
}

class _ExchangeRatesRow extends StatelessWidget {
  const _ExchangeRatesRow({
    required this.exchangeRates,
  });

  final Map<String, ExchangeRate> exchangeRates;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: exchangeRates.values
          .map(
            (exchangeRate) => SizedBox(
              width: 120,
              child: _ExchangeRateCard(exchangeRate: exchangeRate),
            ),
          )
          .toList(),
    );
  }
}

class _ExchangeRateCard extends StatelessWidget {
  const _ExchangeRateCard({
    required this.exchangeRate,
  });

  final ExchangeRate exchangeRate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _CryptoName(
                    name: exchangeRate.baseCurrency,
                  ),
                ),
                _ChangeDirection(
                  isDecreasing: exchangeRate.changeInLast24Hours < 0,
                ),
              ],
            ),
            _Rate(rate: exchangeRate.rate),
          ],
        ),
      ),
    );
  }
}

class _Rate extends StatelessWidget {
  const _Rate({
    Key? key,
    required this.rate,
  }) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Text('\$$rate');
  }
}

class _ChangeDirection extends StatelessWidget {
  const _ChangeDirection({
    Key? key,
    required this.isDecreasing,
  }) : super(key: key);

  final bool isDecreasing;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isDecreasing ? Icons.trending_down : Icons.trending_up,
      color: isDecreasing ? Colors.red : Colors.green,
    );
  }
}

class _CryptoName extends StatelessWidget {
  const _CryptoName({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

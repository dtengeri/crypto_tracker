import 'package:crypto_tracker/core/core.dart';
import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:flutter/material.dart';

class ExchangeRates extends StatefulWidget {
  const ExchangeRates({
    super.key,
    required this.exchangeRatesRepository,
  });

  final ExchangeRatesRepository exchangeRatesRepository;

  @override
  State<ExchangeRates> createState() => _ExchangeRatesState();
}

class _ExchangeRatesState extends State<ExchangeRates> {
  Map<String, ExchangeRate> _exchangeRates = {};
  bool _isLoading = false;

  void _loadExchangeRates() async {
    setState(() {
      _isLoading = true;
    });
    _exchangeRates = await widget.exchangeRatesRepository.loadExchangeRates();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(
          title: 'Exchange Rates',
          actions: [
            _RefreshExchangeRatesButton(
              onRefresh: _loadExchangeRates,
            ),
            if (_isLoading) const _ExhangeRatesLoadingIndicator()
          ],
        ),
        _ExhangeRatesGrid(
          exchangeRates: _exchangeRates,
        ),
      ],
    );
  }
}

class _RefreshExchangeRatesButton extends StatelessWidget {
  const _RefreshExchangeRatesButton({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onRefresh,
      icon: const Icon(Icons.refresh),
    );
  }
}

class _ExhangeRatesLoadingIndicator extends StatelessWidget {
  const _ExhangeRatesLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class _ExhangeRatesGrid extends StatelessWidget {
  const _ExhangeRatesGrid({
    required this.exchangeRates,
  });

  final Map<String, ExchangeRate> exchangeRates;

  @override
  Widget build(BuildContext context) {
    return _ExchangeRatesRow(
      exchangeRates: exchangeRates,
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

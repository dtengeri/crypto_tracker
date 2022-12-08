class ExchangeRate {
  const ExchangeRate({
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.changeInLast24Hours,
  });
  final String baseCurrency;
  final String targetCurrency;
  final double rate;
  final double changeInLast24Hours;
}

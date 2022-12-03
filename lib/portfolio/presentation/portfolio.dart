import 'package:crypto_tracker/exchange_rates/exchange_rates.dart';
import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({
    super.key,
    required this.accountRepository,
    this.exchangeRatesRepository,
  });

  final AccountRepository accountRepository;
  final ExchangeRatesRepository? exchangeRatesRepository;

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<Account> _accounts = [];
  bool _isLoading = false;
  Map<String, ExchangeRate> _exchangeRates = {};

  void _loadExchangeRates() async {
    _exchangeRates =
        await widget.exchangeRatesRepository?.loadExchangeRates() ?? {};
    setState(() {});
  }

  Future<void> _loadAccounts() async {
    setState(() {
      _isLoading = true;
    });
    _accounts = await widget.accountRepository.loadAccounts();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveAccount(Account account) async {
    await widget.accountRepository.addAccount(account);
    await _loadAccounts();
  }

  Future<void> _updateAccount(Account account) async {
    await widget.accountRepository.updateAccount(account);
    await _loadAccounts();
  }

  @override
  void initState() {
    super.initState();
    _loadAccounts();
    _loadExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
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
            _AddAccountButton(
              onSave: _saveAccount,
            ),
            IconButton(
              onPressed: _loadAccounts,
              icon: const Icon(Icons.refresh),
            ),
            if (_isLoading) const CircularProgressIndicator(),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _AccountList(
              accounts: _accounts,
              onUpdateAccount: _updateAccount,
              exchangeRates: _exchangeRates,
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountList extends StatelessWidget {
  const _AccountList({
    required this.accounts,
    required this.onUpdateAccount,
    required this.exchangeRates,
  });

  final List<Account> accounts;
  final void Function(Account account) onUpdateAccount;
  final Map<String, ExchangeRate> exchangeRates;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) => _AccountListItem(
        account: accounts[index],
        onUpdateAccount: onUpdateAccount,
        exchangeRate: exchangeRates[accounts[index].coin],
      ),
    );
  }
}

class _AddAccountButton extends StatelessWidget {
  const _AddAccountButton({
    required this.onSave,
  });

  final void Function(Account account) onSave;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final coin = await showDialog<String>(
          context: context,
          builder: (context) => const _AddAccountDialog(),
        );
        if (coin != null && coin.isNotEmpty) {
          onSave(Account(coin: coin, balance: 0));
        }
      },
      icon: const Icon(Icons.add),
    );
  }
}

class _AddAccountDialog extends StatefulWidget {
  const _AddAccountDialog();

  @override
  State<_AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<_AddAccountDialog> {
  final TextEditingController _addAccountTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _addAccountTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            Navigator.of(context).pop(_addAccountTextEditingController.text);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _AccountListItem extends StatefulWidget {
  const _AccountListItem({
    required this.account,
    required this.onUpdateAccount,
    this.exchangeRate,
  });

  final Account account;
  final void Function(Account account) onUpdateAccount;
  final ExchangeRate? exchangeRate;

  @override
  State<_AccountListItem> createState() => _AccountListItemState();
}

class _AccountListItemState extends State<_AccountListItem> {
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
  void didUpdateWidget(covariant _AccountListItem oldWidget) {
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
            widget.onUpdateAccount(
              Account(
                coin: widget.account.coin,
                balance:
                    double.tryParse(_balanceTextEditingController.text) ?? 0,
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

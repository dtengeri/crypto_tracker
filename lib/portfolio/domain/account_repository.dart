import 'package:crypto_tracker/portfolio/portfolio.dart';

abstract class AccountRepository {
  Future<List<Account>> loadAccounts();
  Future<void> addAccount(Account account);
  Future<void> updateAccount(Account account);
}

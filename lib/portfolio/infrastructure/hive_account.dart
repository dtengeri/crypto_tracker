import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:hive/hive.dart';

part 'hive_account.g.dart';

@HiveType(typeId: 1)
class HiveAccount extends HiveObject {
  HiveAccount({
    required this.coin,
    required this.balance,
  });

  factory HiveAccount.fromDomain(Account account) => HiveAccount(
        coin: account.coin,
        balance: account.balance,
      );

  @HiveField(0)
  final String coin;
  @HiveField(1)
  final double balance;

  Account toDomain() => Account(
        coin: coin,
        balance: balance,
      );
}

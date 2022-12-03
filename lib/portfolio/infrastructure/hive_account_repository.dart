import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _boxName = 'accounts';

class HiveAccountRepository extends AccountRepository {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveAccountAdapter());
    await Hive.openBox<HiveAccount>(_boxName);
  }

  @override
  Future<List<Account>> loadAccounts() async {
    return Hive.box<HiveAccount>(_boxName)
        .values
        .map((hiveAccount) => hiveAccount.toDomain())
        .toList();
  }

  @override
  Future<void> addAccount(Account account) async {
    await Hive.box<HiveAccount>(_boxName)
        .put(account.coin, HiveAccount.fromDomain(account));
  }

  @override
  Future<void> updateAccount(Account account) async {
    await Hive.box<HiveAccount>(_boxName)
        .put(account.coin, HiveAccount.fromDomain(account));
  }
}

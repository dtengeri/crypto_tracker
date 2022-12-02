import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject with EquatableMixin {
  Account({
    required this.coin,
    required this.balance,
  });
  @HiveField(0)
  final String coin;
  @HiveField(1)
  final double balance;

  @override
  List<Object?> get props => [coin, balance];
}

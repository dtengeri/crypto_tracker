import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'portfolio_actor_state.dart';

class PortfolioActorCubit extends Cubit<PortfolioActorState> {
  PortfolioActorCubit() : super(const PortfolioActorState());

  Future<void> addAccount(Account account) async {
    await Hive.box<Account>('accounts').put(account.coin, account);
  }

  Future<void> updateAccount(Account account) async {
    await Hive.box<Account>('accounts').put(account.coin, account);
  }
}

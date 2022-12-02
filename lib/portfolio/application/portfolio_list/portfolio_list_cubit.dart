import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/portfolio/portfolio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'portfolio_list_state.dart';

class PortfolioListCubit extends Cubit<PortfolioListState> {
  PortfolioListCubit() : super(const PortfolioListState.initial());

  void loadAccounts() {
    emit(state.copyWith(areAccountsLoading: true));
    final accounts = Hive.box<Account>('accounts').values.toList();
    emit(state.copyWith(
      accounts: accounts,
      areAccountsLoaded: true,
      areAccountsLoading: false,
    ));
  }
}

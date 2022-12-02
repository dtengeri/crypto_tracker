part of 'portfolio_list_cubit.dart';

class PortfolioListState extends Equatable {
  const PortfolioListState({
    required this.accounts,
    required this.areAccountsLoading,
    required this.areAccountsLoaded,
  });

  const PortfolioListState.initial()
      : this(
          accounts: const [],
          areAccountsLoading: false,
          areAccountsLoaded: false,
        );

  final List<Account> accounts;
  final bool areAccountsLoading;
  final bool areAccountsLoaded;

  PortfolioListState copyWith({
    List<Account>? accounts,
    bool? areAccountsLoading,
    bool? areAccountsLoaded,
  }) =>
      PortfolioListState(
        accounts: accounts ?? this.accounts,
        areAccountsLoading: areAccountsLoading ?? this.areAccountsLoading,
        areAccountsLoaded: areAccountsLoaded ?? this.areAccountsLoaded,
      );

  @override
  List<Object?> get props => [
        accounts,
        areAccountsLoading,
        areAccountsLoaded,
      ];
}

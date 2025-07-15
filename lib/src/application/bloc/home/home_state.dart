import 'package:tap_project/src/application/model/bonds_model.dart';

class HomeState {
  BondsResponse? bondsList;
  String? errorMessage;
  bool isLoading;
  String? searchValue;

  HomeState({
    this.bondsList,
    this.errorMessage,
    this.isLoading = false,
    this.searchValue,
  });

  HomeState copyWith({
    BondsResponse? bondsList,
    String? errorMessage,
    bool? isLoading,
    String? searchValue,
  }) {
    return HomeState(
      bondsList: bondsList ?? this.bondsList,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}

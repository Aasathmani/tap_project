import 'package:tap_project/src/application/model/company_model.dart';

class CompanyState {
  CompanyModel? companyModel;
  bool isLoading;
  String? errorMessage;
  String selectedMetric;

  CompanyState({
    this.companyModel,
    this.isLoading = false,
    this.errorMessage,
    this.selectedMetric = "EBITDA",
  });
  CompanyState copyWith({
    CompanyModel? companyModel,
    bool? isLoading,
    String? errorMessage,
    String? selectedMetric,
  }) {
    return CompanyState(
      companyModel: companyModel ?? this.companyModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedMetric: selectedMetric ?? this.selectedMetric,
    );
  }
}

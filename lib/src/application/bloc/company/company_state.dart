import 'package:tap_project/src/application/model/company_model.dart';

class CompanyState{
  CompanyModel? companyModel;
  bool isLoading;
  String? errorMessage;

  CompanyState({
    this.companyModel,
    this.isLoading=false,
    this.errorMessage,
});
  CompanyState copyWith({
    CompanyModel? companyModel,
    bool? isLoading,
    String? errorMessage,
}){
    return CompanyState(
      companyModel: companyModel ?? this.companyModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
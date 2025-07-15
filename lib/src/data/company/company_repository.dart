import 'package:tap_project/src/application/model/company_model.dart';
import 'package:tap_project/src/data/company/company_service.dart';

class CompanyRepository {
  static CompanyRepository? instance;
  final CompanyService companyService;
  CompanyRepository({required this.companyService});

  Future<CompanyModel> getCompanyDetails() async {
    final dataFromResponse = await companyService.fetchCompanyDetails();
    final data = _companyDetails(dataFromResponse.data);
    return data;
  }

  CompanyModel _companyDetails(Map<String, dynamic> json) {
    return CompanyModel.fromJson(json);
  }
}

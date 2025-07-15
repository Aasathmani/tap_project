import 'package:tap_project/src/application/bloc/company/company_bloc.dart';
import 'package:tap_project/src/application/bloc/home/home_bloc.dart';
import 'package:tap_project/src/data/company/company_repository.dart';
import 'package:tap_project/src/data/company/company_service.dart';
import 'package:tap_project/src/data/home/home_repository.dart';
import 'package:tap_project/src/data/home/home_service.dart';

HomeBloc provideHomeBloc() {
  return HomeBloc(homeRepository: provideHomeRepository());
}

HomeRepository provideHomeRepository() {
  return HomeRepository.instance ??= HomeRepository(homeService: HomeService());
}

CompanyBloc provideCompanyBloc() {
  return CompanyBloc(companyRepository: provideCompanyRepository());
}

CompanyRepository provideCompanyRepository() {
  return CompanyRepository.instance ??= CompanyRepository(
    companyService: CompanyService(),
  );
}

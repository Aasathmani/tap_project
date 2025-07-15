import 'package:bloc/bloc.dart';
import 'package:tap_project/src/application/bloc/company/company_event.dart';
import 'package:tap_project/src/application/bloc/company/company_state.dart';
import 'package:tap_project/src/data/company/company_repository.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;
  CompanyBloc({required this.companyRepository}) : super(CompanyState()) {
    on<OnInit>((event, emit) async {
      await _onInit(event, emit);
    });
    add(OnInit());
  }

  Future<void> _onInit(OnInit event, Emitter<CompanyState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final data = await companyRepository.getCompanyDetails();
      emit(state.copyWith(companyModel: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}

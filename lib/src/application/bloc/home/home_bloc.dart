import 'package:bloc/bloc.dart';
import 'package:tap_project/src/application/bloc/home/home_event.dart';
import 'package:tap_project/src/application/bloc/home/home_state.dart';
import 'package:tap_project/src/data/home/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeState()) {
    on<OnInit>((event, emit) async {
      await _onInit(event, emit);
    });
    on<SearchFieldChange>((event,emit){
      emit(state.copyWith(searchValue: event.searchValue));
    });
    add(OnInit());
  }

  Future<void> _onInit(OnInit event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final data = await homeRepository.getBondsList();
      emit(state.copyWith(bondsList: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}

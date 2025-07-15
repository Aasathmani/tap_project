import 'package:bloc/bloc.dart';
import 'package:tap_project/src/application/bloc/splash/splash_event.dart';
import 'package:tap_project/src/application/bloc/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<Init>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(navigation: Navigation.home));
    });
    add(Init());
  }
}

enum Navigation { home, none }

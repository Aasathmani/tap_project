import 'package:flutter/cupertino.dart';
import 'package:tap_project/src/application/bloc/splash/splash_bloc.dart';

class SplashState {
  Navigation navigation;

  SplashState({this.navigation = Navigation.none});
  SplashState copyWith({Navigation? navigation}) {
    return SplashState(navigation: navigation ?? this.navigation);
  }
}

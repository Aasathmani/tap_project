import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_project/generated/l10n.dart';
import 'package:tap_project/src/application/bloc/splash/splash_bloc.dart';
import 'package:tap_project/src/application/bloc/splash/splash_state.dart';
import 'package:tap_project/src/presentation/core/text_styles.dart';
import 'package:tap_project/src/presentation/home/home_page.dart';

class SplashPage extends StatefulWidget {
  static const route = '/';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= BlocProvider.of<SplashBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.navigation == Navigation.home) {
          Navigator.popAndPushNamed(context, HomePage.route);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(
              S.current.labelWelcome,
              style: TextStyles.h4Bold(context),
            ),
          ),
        );
      },
    );
  }
}

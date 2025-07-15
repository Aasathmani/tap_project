import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_project/src/application/bloc/splash/splash_bloc.dart';
import 'package:tap_project/src/core/bloc_provider.dart';
import 'package:tap_project/src/presentation/home/home_page.dart';
import '../presentation/company/company_page.dart';
import '../presentation/splash/splash_page.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  SplashPage.route: (_) =>
      BlocProvider(create: (context) => SplashBloc(), child: SplashPage()),
  HomePage.route: (_) =>
      BlocProvider(create: (context) => provideHomeBloc(), child: HomePage()),
  CompanyPage.route: (_) => BlocProvider(
    create: (context) => provideCompanyBloc(),
    child: CompanyPage(),
  ),
};

Route<dynamic>? generatedRoutes(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  debugPrint("URI.PATH : ${uri.path}");
  debugPrint("URI.queryParams : ${uri.queryParameters}");
  debugPrint("Settings : ${settings.name}");
  debugPrint("Arguments :  ${settings.arguments ?? "null"}");
  return null;

  // switch (uri.path) {
  //   case HomePage.route:
  //     if (settings.arguments != null && settings.arguments is HomePageArgument) {
  //       return _getWebViewRoute(
  //         settings,
  //         settings.arguments! as HomePageArgument,
  //       );
  //     }
  // }
}

// MaterialPageRoute _getWebViewRoute(
//     RouteSettings settings,
//     HomePageArgument argument,
//     ) {
//   return MaterialPageRoute(
//     builder: (context) => BlocProvider<HomeBloc>(
//       create: (context) => provideWebViewBloc(argument),
//       child: const HomePage(),
//     ),
//     settings: settings,
//   );
// }

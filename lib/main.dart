import 'package:flutter/material.dart';
import 'package:tap_project/src/core/route.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: routes,
      onGenerateRoute: (settings) => generatedRoutes(settings),
    );
  }
}

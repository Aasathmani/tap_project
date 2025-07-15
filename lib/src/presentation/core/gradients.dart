import 'package:flutter/material.dart';
import 'package:tap_project/src/presentation/core/colors.dart';

Gradient topToBottomLinearGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColorLight,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Gradient buttonGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColorLight,
    ],
  );
}

Gradient blueToIndigoGradient(BuildContext context) {
  return const LinearGradient(
    colors: [
      AppColors.cyanBlue, // Bright cyan blue
      AppColors.deepIndigo, // Deep indigo
    ],
  );
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';

/*
*
* Cette classe définit un gradiant pour le fond de l'appli
*
* */

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFF99DAFF);
  static const Color loginGradientEnd = const Color(0xFF008080);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
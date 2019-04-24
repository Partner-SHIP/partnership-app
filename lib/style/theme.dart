import 'dart:ui';

import 'package:flutter/cupertino.dart';

/*
*
* Cette classe définit un gradiant pour le fond de l'appli
*
* */

class Gradients {
  static AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static AlignmentGeometry _endAlignment = Alignment.bottomRight;

  static LinearGradient buildGradient(AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
      LinearGradient(begin: begin, end: end, colors: colors);

  static LinearGradient hotLinear =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffF55B9A), Color(0xffF9B16E)]);

  static LinearGradient serve =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff485563), Color(0xff485563)]);

  static LinearGradient ali =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffff4b1f), Color(0xff1fddff)]);

  static LinearGradient aliHussien =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xfff7ff00), Color(0xffdb36a4)]);

  static LinearGradient backToFuture =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffC02425), Color(0xffF0CB35)]);

  static LinearGradient tameer =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff136a8a), Color(0xff267871)]);

  static LinearGradient rainbowBlue =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff00F260), Color(0xff0575E6)]);

  static LinearGradient blush =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffB24592), Color(0xffF15F79)]);

  static LinearGradient byDesign =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff009FFF), Color(0xffec2F4B)]);

  static LinearGradient haze =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffE8EDF4), Color(0xffF6F6F8)]);

  static LinearGradient jShine =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff12c2e9), Color(0xffc471ed), Color(0xfff64f59)]);

  static LinearGradient hersheys = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfff1e130c),
    Color(0xff9a8478),
  ]);

  static LinearGradient taitanum = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff283048),
    Color(0xff859398),
  ]);

  static LinearGradient cosmicFusion = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfffff00cc),
    Color(0xff333399),
  ]);

  static LinearGradient coldLinear = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfff20BDFF),
    Color(0xffA5FECB),
  ]);

  static LinearGradient deepSpace = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff000000),
    Color(0xff434343),
  ]);

  static LinearGradient metallic = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffffffff),
    Color(0xffbdbdbd),
  ]);
}

class Theme {

  const Theme();

  static const Color loginGradientStart = const Color(0xFF99DAFF);
  static const Color loginGradientEnd = const Color(0xFF008080);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
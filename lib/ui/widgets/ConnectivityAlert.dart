import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar connectivityAlertWidget() {
  return Flushbar(
    title: "Internet Connection Status",
    message: "Your device is currently offline, some of Partnership's features are disabled.",
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    boxShadow: BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0),
    backgroundGradient: LinearGradient(colors: [Colors.red, Colors.black]),
    isDismissible: true,
    icon: Icon(
      Icons.info_outline,
      color: Colors.amber,
    ),
    showProgressIndicator: false,
    progressIndicatorBackgroundColor: Colors.blueGrey,
  );
}
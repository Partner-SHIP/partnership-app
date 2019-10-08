import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:partnership/style/theme.dart';

void openTextDialog(BuildContext context, String title, String text){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(text),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Fermer"),
            onPressed: () =>
                Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

void openSettingsDialog(BuildContext context, String title){
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(gradient: AThemes.getTheme(theme: enumTheme.DAWN).bgGradient),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(gradient: AThemes.getTheme(theme: enumTheme.OCEAN).bgGradient),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(gradient: AThemes.getTheme(theme: enumTheme.MARINE).bgGradient),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("DAWN"),
              onPressed: () {
                AThemes.changeTheme(newTheme: enumTheme.DAWN);
              }
            ),
            FlatButton(
              child: Text("OCEAN"),
              onPressed: () =>
                  AThemes.changeTheme(newTheme: enumTheme.OCEAN),
            ),
            FlatButton(
              child: Text("MARINE"),
              onPressed: () =>
                  AThemes.changeTheme(newTheme: enumTheme.MARINE),
            ),
            FlatButton(
              child: Text("Fermer"),
              onPressed: () =>
                  Navigator.of(context).pop(),
            )

          ],
        );
      }
  );
}



void openSpinnerInDialog(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: FlareActor('assets/animations/Liquid Loader.flr', animation: 'Untitled')
        ),
      );
    },
  );
  Future.delayed(Duration(seconds: 5), () {
    Navigator.pop(context); //pop dialog
  }
  );
}

/*
class CustomSpinner extends StatefulWidget {
  @override
  CustomSpinnerState createState() => CustomSpinnerState();
}

class CustomSpinnerState extends State<CustomSpinner> with SingleTickerProviderStateMixin {
  Animation<double>   _angleAnimation;
  Animation<double>   _scaleAnimation;
  AnimationController _controller;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _angleAnimation = Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener((){
        setState(() {});
      });
    _scaleAnimation = Tween(begin: 1.0, end: 6.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _controller.reverse();
      else if (status == AnimationStatus.dismissed)
        _controller.forward();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Center(
        child: _buildAnimation(),
      );
  }

  Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = Container(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: Column(
        children: <Widget>[
          Row (
            children: <Widget>[
              _buildCircle(circleWidth,Colors.blue),
              _buildCircle(circleWidth,Colors.red),
            ],
          ),
          Row (
            children: <Widget>[
              _buildCircle(circleWidth,Colors.yellow),
              _buildCircle(circleWidth,Colors.green),
            ],
          ),
        ],
      ),
    );
    double angleInDegrees = _angleAnimation.value;
    return Transform.rotate(
      angle: angleInDegrees / 360 * 2 * pi,
      child: Container(
        child: circles,
      ),
    );
  }

  Widget _buildCircle(double circleWidth, Color color) {
    return Container(
      width: circleWidth,
      height: circleWidth,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
*/
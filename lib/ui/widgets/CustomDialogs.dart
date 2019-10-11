import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/viewmodel/AViewModel.dart';

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

void openSettingsDialog(BuildContext context, String title, AViewModel viewModel){
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return SettingsWidget(title, viewModel);
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

class SettingsWidget extends StatefulWidget {
  SettingsWidget(String title, AViewModel viewModel) : _title = title, _viewModel = viewModel;
  final String _title;
  final AViewModel _viewModel;
  @override
  State<SettingsWidget> createState() {
    return SettingsWidgetState(_title, _viewModel);
  }
}
class SettingsWidgetState extends State<SettingsWidget> {
  SettingsWidgetState(String title, AViewModel viewModel) : _title = title, _viewModel = viewModel;
  final String _title;
  final AViewModel _viewModel;
  final Map<enumTheme, bool> _themeCheckMap = {};

  @override
  void initState(){
    super.initState();
    enumTheme.values.forEach((v) => _themeCheckMap[v] = false);
    _themeCheckMap[AThemes.selectedTheme.theme] = true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(_title, style: TextStyle(fontFamily: 'Orkney', fontWeight: FontWeight.bold)),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              child: AutoSizeText('THEMES', style: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Orkney', fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(bottom: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: AThemes.getTheme(theme: enumTheme.DAWN).bgGradient,
                    ),
                    child: (_themeCheckMap[enumTheme.DAWN]) ? Center(child: Icon(Icons.check_circle, size: MediaQuery.of(context).size.width / 6, color: Colors.green))
                                  : Center(child: AutoSizeText("DAWN", style: TextStyle(fontFamily: 'Orkney', fontWeight: FontWeight.bold, color: Colors.white))),
                  ),
                  onTap: () {
                    setState(() {
                      _themeCheckMap[AThemes.selectedTheme.theme] = false;
                      _themeCheckMap[enumTheme.DAWN] = true;
                    });
                    AThemes.changeTheme(newTheme: enumTheme.DAWN);
                    _viewModel.reloadView();
                  },
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), gradient: AThemes.getTheme(theme: enumTheme.OCEAN).bgGradient),
                    child: (_themeCheckMap[enumTheme.OCEAN])  ? Center(child: Icon(Icons.check_circle, size: MediaQuery.of(context).size.width / 6, color: Colors.green))
                                                              : Center(child: AutoSizeText("OCEAN", style: TextStyle(fontFamily: 'Orkney', fontWeight: FontWeight.bold, color: Colors.white))),
                  ),
                  onTap: () {
                    setState(() {
                      _themeCheckMap[AThemes.selectedTheme.theme] = false;
                      _themeCheckMap[enumTheme.OCEAN] = true;
                    });
                    AThemes.changeTheme(newTheme: enumTheme.OCEAN);
                    _viewModel.reloadView();
                  },
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), gradient: AThemes.getTheme(theme: enumTheme.MARINE).bgGradient),
                    child: (_themeCheckMap[enumTheme.MARINE]) ? Center(child: Icon(Icons.check_circle, size: MediaQuery.of(context).size.width / 6, color: Colors.green))
                                                              : Center(child: AutoSizeText("MARINE", style: TextStyle(fontFamily: 'Orkney', fontWeight: FontWeight.bold, color: Colors.white))),
                  ),
                  onTap: () {
                    setState(() {
                      _themeCheckMap[AThemes.selectedTheme.theme] = false;
                      _themeCheckMap[enumTheme.MARINE] = true;
                    });
                    AThemes.changeTheme(newTheme: enumTheme.MARINE);
                    _viewModel.reloadView();
                  },
                ),
              ],
            )
          ],
        ),
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
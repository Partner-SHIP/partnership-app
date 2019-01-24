import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _scaffoldContext;
  LoginPageViewModel get viewModel =>
      AViewModelFactory.register[Routes.loginPage];

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;

    final topContainer = Container(
      child: Center(
          child: Align(
        child: Image.asset(
          'assets/img/work-office.png',
        ),
      )),
    );

    //snackbar ne s'affiche pas
    onPressForgot() {
      Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
        content: new Text('Server error'),
        duration: new Duration(seconds: 5),
      ));
    }

    final alreadyAccountButton = LargeButton(
      text:"J'ai déjà un compte",
      onPressed: () => this.viewModel.changeView(route: Routes.signInPage, widgetContext: context)
    );

    final signUpButton = LargeButton(
      text:"Je veux m'inscrire",
      onPressed: () => this.viewModel.changeView(route: Routes.signUpPage, widgetContext: context)
    );

    final whatIsButton = FlatButton(
      child: Text('Mais c\'est quoi PartnerSHIP ?',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          )),
      onPressed: () {
        onPressForgot();
      },
    );

    final bottomContainer = Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/img/logo_partnership.png',
            height: 150,
          ),
          alreadyAccountButton,
          signUpButton,
          whatIsButton,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
            child: Container(
      /*decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.grey,
            Colors.grey[300],
            Colors.grey[800],
            Colors.lightBlue
          ],
        ),
      ),*/
      child: Column(
        children: <Widget>[topContainer, bottomContainer],
      ),
      // backgroundColor: Colors.grey[300],
    )));
  }
}

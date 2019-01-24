import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';

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

    final alreadyAccountButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text('J\'ai déjà un compte',
              style: TextStyle(color: Colors.white)),
          onPressed: () {
            this
                .viewModel
                .changeView(route: Routes.signInPage, widgetContext: context);
            //Navigator.pushNamed(context, Routes.signInPage);
          },
        ),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text('Je veux m\'inscrire',
              style: TextStyle(color: Colors.white)),
          onPressed: () {
            //this.viewModel.changeView(route: Routes.signUpPage, widgetContext: context);
            Navigator.pushNamed(context, Routes.signUpPage);
          },
        ),
      ),
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
            'assets/img/logoPartnerSHIP.png',
            height: 150,
          ),
          alreadyAccountButton,
          signUpButton,
          whatIsButton,
        ],
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      decoration: BoxDecoration(
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
      ),
      child: Column(
        children: <Widget>[topContainer, bottomContainer],
      ),
      // backgroundColor: Colors.grey[300],
    )));
  }
}

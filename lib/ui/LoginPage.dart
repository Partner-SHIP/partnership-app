import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  BuildContext _scaffoldContext;
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  LoginPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.loginPage];

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

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
      onPressed: () {
        this.viewModel.changeView(route: _routing.signInPage, widgetContext: context);
      }
    );

    final signUpButton = LargeButton(
      text:"Je veux m'inscrire",
      onPressed: () { this
                .viewModel
                .changeView(route: _routing.signUpPage, widgetContext: context);
      }

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
      child: Column(
        children: <Widget>[topContainer, bottomContainer],
      ),
    )));
  }

  void _connectivityHandler(bool value) {
    if (!value){
      viewModel.showConnectivityAlert(context);
    }
  }
}

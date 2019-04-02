import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:flushbar/flushbar.dart';
import 'package:partnership/ui/widgets/ConnectivityAlert.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  BuildContext _scaffoldContext;
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  Flushbar _connectivityAlert;
  LoginPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.loginPage];

  @override
  void initState(){
    super.initState();
    this._connectivityAlert = connectivityAlertWidget();
    this._connectivitySub = viewModel.subscribeToConnectivity(this.connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    Color backgroundColor = Colors.grey[850];
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
        text: "J'ai déjà un compte",
        onPressed: () {
          this
              .viewModel
              .changeView(route: _routing.signInPage, widgetContext: context);
        });

    final signUpButton = LargeButton(
        text: "Je veux m'inscrire",
        onPressed: () {
          this
              .viewModel
              .changeView(route: _routing.signUpPage, widgetContext: context);
        });

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = 240;
    final double paddingHeight = 24;
    final double paddedHeight = MediaQuery.of(context).size.height - paddingHeight;
    final BoxDecoration backgroundFade = BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/img/work-office.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.srcATop)),
        color: Colors.red);
    final Container topContainer = Container(
      height: bannerHeight,
      width: screenWidth,
      decoration: backgroundFade,
      child: Image.asset('assets/img/logo_partnership.png'),
      padding: EdgeInsets.only(
          top: bannerHeight * 1 / 20, bottom: bannerHeight * 1 / 10),
    );
    final bottomContainer = Container(
      width: screenWidth,
        height: paddedHeight - bannerHeight,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        alreadyAccountButton,
        signUpButton,
        whatIsButton,
      ],
    ));

    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: paddingHeight),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[topContainer, bottomContainer],
          ),
        )));
  }

  void connectivityHandler(bool value) {
    if (!value)
      this._connectivityAlert.show(context);
    else
    {
      if (this._connectivityAlert.isShowing() && !this._connectivityAlert.isDismissed())
        this._connectivityAlert.dismiss();
    }
  }
}

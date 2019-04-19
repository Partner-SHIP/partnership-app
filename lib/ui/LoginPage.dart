import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:permission/permission.dart';
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


    final alreadyAccountButton = LargeButton(
        text: "J'ai déjà un compte",
        onPressed: () {
          this
              .viewModel
              .changeView(route: _routing.signInPage, widgetContext: context);
        });

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
      },
    );


    final topContainer = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/work-office.png'),
            fit: BoxFit.fill
        )
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      );

    final botContainer = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/logo_partnership.png'),
              fit: BoxFit.fitHeight
          )
      ),
      child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[
                  SizedBox(width: 0, height: 50),
                  Center(child: Text("PartnerShip",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                          //fontFamily: 'PeaceSans'
                      )
                  )
                  ),
                  SizedBox(width: 0, height: 30),
                  alreadyAccountButton,
                  signUpButton,
                  whatIsButton,
                ],
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  //borderRadius: BorderRadius.all(Radius.circular(10))
                ),
            ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2.25,
    );

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
            child: SingleChildScrollView(
                    child: Column(
                    children: <Widget>[
                      topContainer,
                      botContainer,
                    ],
          ),
        ))
    );
  }



  void _connectivityHandler(bool value) async {
    if (!value){
      viewModel.showConnectivityAlert(context);
      //List<Permissions> permissionNames = await Permission.requestPermissions([PermissionName.Calendar, PermissionName.Camera]);

      //Permission.openSettings();
    }
  }
}

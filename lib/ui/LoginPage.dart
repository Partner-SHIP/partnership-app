import 'package:flutter/material.dart';
import 'dart:ui';
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

    final titleWidget = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff20264c).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff20264c).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            ),
            Text('PartnerShip',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Copperhead',
                  fontSize: 35
              )
            ),
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff35294f).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff35294f).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            )
          ],
        )
      );

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin:Alignment.topCenter, end:Alignment.bottomCenter,colors: [Color(0xff14244a), Color(0xff82365c)])
              ),
              child: Column(children: <Widget>[
                Padding(
                  child: Image.asset('assets/img/logo_partnership.png', width:50, height: 50),
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                ),
                titleWidget
              ]),
            )
        )
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

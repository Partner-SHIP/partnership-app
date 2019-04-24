import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';
import 'package:partnership/style/theme.dart';
import 'dart:async';
import 'dart:ui';

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
                  fontFamily: 'Copperplate',
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

    final logButtonsWidget = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RoundedGradientButton(
              gradient: Gradients.metallic,
              child: Text(
                  'CONNEXION',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Orkney',
                  ),
              ),
              callback: () => viewModel.changeView(route: _routing.signInPage, widgetContext: context),
              increaseWidthBy: 80,
              increaseHeightBy: 10
          ),
          RoundedGradientButton(
              gradient: Gradients.metallic,
              child: Text(
                'INSCRIPTION',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Orkney',
                ),
              ),
              callback: () => viewModel.changeView(route: _routing.signUpPage, widgetContext: context),
              increaseWidthBy: 80,
              increaseHeightBy: 10
          )
        ],
      ),
    );

    final contactButtonsWidget = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                _openContactModal(widgetContext: context);
              },
              child: Text(
                'CONTACTEZ-NOUS',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Orkney',
                ),
              )
          ),
          Container(child: null, width: 10, height: 3, color: Colors.white),
          FlatButton(
              onPressed: () => viewModel.showPartnershipInfoWebSite(),
              child: Text(
                'MAIS C\'EST QUOI PARTNERSHIP ?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Orkney',
                ),
              )
          )
        ],
      ),
    );

    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                titleWidget,
                Padding(
                  child: logButtonsWidget,
                  padding: EdgeInsets.only(top: 50, bottom: 30)
                ),
                contactButtonsWidget
              ]),
            )
        )
    );
  }

  void _openContactModal({@required BuildContext widgetContext}){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(
          "Votre Message:",
          style: TextStyle(fontFamily: 'Orkney'),
        ),
        content: SingleChildScrollView(
            child: Container(
              //width: MediaQuery.of(context).size.width / 2,
              child: Form(
                  child: Column(
                  children: <Widget>[
                    Text(
                      'Sujet:',
                        style: TextStyle(fontFamily: 'Orkney')
                    ),
                    TextFormField(),
                    Text(
                      'Message:',
                        style: TextStyle(fontFamily: 'Orkney')
                    ),
                    TextFormField()
                  ],
                )
              ),
            )
        ),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Annuler",
                style: TextStyle(fontFamily: 'Orkney')
              ),
              onPressed: () => Navigator.of(context).pop()
          ),
          FlatButton(
              child: Text(
                "Envoyer",
                style: TextStyle(fontFamily: 'Orkney')
              ),
              onPressed: () {
                viewModel.contactUsByInAppMail(subject: null, message: null).then((_) {
                  Navigator.of(context).pop();
                });
              }
          )
        ],
      );
    });
  }

  void _connectivityHandler(bool value) async {
    if (!value){
      viewModel.showConnectivityAlert(context);
    }
  }
}

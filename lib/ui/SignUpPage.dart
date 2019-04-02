import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignUpPageViewModel.dart';
import 'package:flushbar/flushbar.dart';
import 'package:partnership/ui/widgets/ConnectivityAlert.dart';
import 'dart:async';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  IRoutes _routing = Routes();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  final SignUpData           _data = SignUpData();
  Flushbar _connectivityAlert;
  StreamSubscription _connectivitySub;
  bool  busy = false;

  SignUpPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signUpPage];
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
    final Size screenSize = MediaQuery.of(context).size;

    final topBar = AppBar(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: Text('Inscription'),
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
          child: Text('Je m\'inscris', style: TextStyle(color: Colors.white)),
          onPressed: () {
            if (this._formKey.currentState.validate()) {
              this._formKey.currentState.save();
              setState(() {
                busy = true;
              });
              this.viewModel.signUpAction(this._data).then((value){
                if (value) {
                  var snackbar = SnackBar(content: Text("SignUp successful!"), duration: Duration(milliseconds: 5000));
                  this._mainKey.currentState.showSnackBar(snackbar);
                  this.viewModel.changeView(route: this._routing.homePage, widgetContext: context);
                }
                setState(() {
                  busy = false;
                });
              });
            }
          },
        ),
      ),
    );

    final formContainer = Container(
        padding: EdgeInsets.all(20.0),
        width: screenSize.width,
        child: Form(
          key: this._formKey,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/img/logo_partnership.png',
                height: 150,
              ),
              busy ? CircularProgressIndicator() : Container(width: 0, height: 0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return ('Veuillez saisir un pseudo');
                  }
                  //TODO : regex pour le pseudal
                  /* bool nicknameValid =
                        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                    if (!nicknameValid) {
                      return ('Pseudo invalide');
                    }*/
                },
                onSaved: (value) => this._data.nickname = value,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.supervisor_account,
                    color: Colors.grey,
                  ),
                  hintText: 'Votre pseudo',
                ),
              ),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Veuillez saisir une adresse email valide');
                    }
                    bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                    if (!emailValid) {
                      return ('Email invalide');
                    }
                  },
                  onSaved: (value) => this._data.email = value,
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: 'Une adresse email valide',
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Veuillez saisir un mot de passe');
                    }
                    //TODO regex pour le mdp

                    /*bool emailValid =
                        RegExp('r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"')
                            .hasMatch(value);
                    if (!emailValid) {
                      return ('Mot de passe invalide');
                    }*/
                  },
                  onSaved: (value) => this._data.password = value,
                  obscureText: true, // Use secure text for passwords.
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.grey,
                    ),
                    hintText: 'Mot de passe',
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Veuillez confirmer votre mot de passe');
                    }
                  },
                  onSaved: (value) => this._data.confirmPassword = value,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.check_circle_outline, color: Colors.grey),
                    hintText: 'Confirmer le mot de passe',
                  )),
              Container(
                width: screenSize.width,
                child: signUpButton,
              )
            ],
          ),
        ));

    final bottomContainer = Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              '-  Ou inscris-toi avec  -',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(FontAwesomeIcons.facebookF),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Icon(FontAwesomeIcons.google),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
        appBar: topBar,
        backgroundColor: Colors.grey[300],
        key: this._mainKey,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[formContainer, bottomContainer],
        )));
  }

  connectivityHandler(bool value) {
    if (!value)
      this._connectivityAlert.show(context);
    else
    {
      if (this._connectivityAlert.isShowing() && !this._connectivityAlert.isDismissed())
        this._connectivityAlert.dismiss();
    }
  }
}

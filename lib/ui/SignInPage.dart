import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignInPageViewModel.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInData           _data = SignInData();
  bool                        busy = false;
  IRoutes _routing = Routes();
  SignInPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signInPage];

  void  displaySuccessSnackBar()
    {
      var snackbar = SnackBar(content: Text("SignIn successful!"), duration: Duration(milliseconds: 5000));
                  this._mainKey.currentState.showSnackBar(snackbar);
    }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final topBar = AppBar(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: Text('Connectez vous'),
      centerTitle: true,
    );

    final signInButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text('Je me connecte', style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              this._formKey.currentState.save();
              setState(() {
                busy = true;
              });
              this.viewModel.signInAction(this._data).then((value){
                if (value) {
                  displaySuccessSnackBar();
                  this.viewModel.afterSignIn(context);
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
              Container(
                width: screenSize.width,
                child: signInButton,
              )
            ],
          ),
        ));

    final bottomContainer = Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              '-  Ou connecte toi avec  -',
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
}


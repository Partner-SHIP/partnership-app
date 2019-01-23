import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignInPageViewModel.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInData {
  String nickname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignInPageViewModel get viewModel => AViewModelFactory.register[Routes.signInPage];

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
              // If the form is valid, we want to show a Snackbar
              //Scaffold.of(context)
              //   .showSnackBar(SnackBar(content: Text('Processing Data')));
              _attemptLogin();
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
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/img/logoPartnerSHIP.png',
                height: 150,
              ),
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
                  onPressed: () {
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );

    /* return Scaffold(
        appBar: topBar,
        backgroundColor: Colors.grey[300],
        body: formContainer
    );*/
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: topBar,
      backgroundColor: Colors.grey[300],
      //body: Container(child: formContainer),
      body: Column(
        children: <Widget>[formContainer, bottomContainer],
      ),
    );
  }

  _attemptLogin() {
    print('login');
  }
}

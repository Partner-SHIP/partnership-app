import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignInPageViewModel.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

/*
class _SignInData {
  String nickname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}
*/

class _SignInPageState extends State<SignInPage> {
  SignInPageViewModel viewModel = AViewModelFactory.register[Routes.signInPage];
  @override
  Widget build(BuildContext context) {
    var elem = AViewModelFactory.register;
    var test = AViewModelFactory.register[Routes.signInPage];
    print("ça c'est register : $elem");
    elem.forEach((String string, AViewModel vm) {
      print("string = $string");
      print("vm = $vm");
    });
    print("$test");
    print("ça c'est null : $viewModel");
    final Widget topBar = buildTopBar();
    final Widget mailConnectionForm = buildForm();
    final Widget alternativeConnectionForm = buildAlternativeConnectionForm();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: topBar,
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[mailConnectionForm, alternativeConnectionForm],
      ),
    );
  }

  Widget buildTopBar() {
    return (AppBar(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: Text('Connectez-vous'),
      centerTitle: true,
    ));
  }

  Widget buildSignInButton() {
    return (Padding(
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
          onPressed: () => viewModel.attemptLogin(),
        ),
      ),
    ));
  }

  Widget buildForm() {
    final signInButton = buildSignInButton();
    final Size screenSize = MediaQuery.of(context).size;
    return (Container(
        padding: EdgeInsets.all(20.0),
        width: screenSize.width,
        child: Form(
          key: this.viewModel.formKey,
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
        )));
  }

  Widget buildAlternativeConnectionForm() {
    return (Container(
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
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:partnership/utils/Routes.dart';
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
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  SignInPageViewModel viewModel = AViewModelFactory.register[Routes.signInPage];
  @override
  Widget build(BuildContext context) {
    this.viewModel.feedGlobalKey(_formkey);

    final Widget topBar = buildTopBar();
    final Widget mailConnectionForm = buildForm(context);
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
    return (LargeButton(
        text: 'Je me connecte',
        onPressed: () => viewModel.attemptLogin(context: context)));
  }

  Widget buildForm(BuildContext context) {
    Widget signInButton = buildSignInButton();
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
              Image.asset('assets/img/logoPartnerSHIP.png', height: 150),
              TextFormField(
                  validator: (value) => viewModel.validateEmail(value),
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors.grey),
                    hintText: 'Une adresse email valide',
                  )),
              TextFormField(
                  validator: (value) => viewModel.validatePassword(value),
                  obscureText: true, // Use secure text for passwords.
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key, color: Colors.grey),
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

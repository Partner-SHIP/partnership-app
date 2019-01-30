import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/UserModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:flutter/material.dart';

class SignInPageViewModel extends AViewModel {
  String _email;
  String _pass;
  UserModel _model;
  GlobalKey<FormState> _formKey;
  GlobalKey<FormState> get formKey => _formKey;
  SignInPageViewModel() : super(Routes.signInPage) {
    this._model = super.abstractModel;
  }
  void feedGlobalKey({@required GlobalKey<FormState> key}) {
    this._formKey = key;
  }
  UserModel get model => this._model;
  void attemptLogin({@required BuildContext context}) {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState.validate()) {
      // If the form is valid, we want to show a Snackbar
      //Scaffold.of(context)
      //   .showSnackBar(SnackBar(content: Text('Processing Data')));
      _formKey.currentState.save();
      _attemptLogin(context:context, mail:_email, pass:_pass);
    }
  }

  String validateEmail(String value) {
    _email = null;
    if (value.isEmpty) {
      return ('Veuillez saisir une adresse email valide');
    }
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
    if (!emailValid) {
      return ('Email invalide');
    }
    _email = value;
    return (null);
  }

  String validatePassword(String value) {
    _pass = null;
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
    _pass = value;
    return (null);
  }
  void _onSignInResult(BuildContext context, bool value, String errorMessage) {
    if (value == true) {
      bool changingViewSuccess;
      print("Authentication success");
      changingViewSuccess = this.changeView(route:Routes.homePage, widgetContext: context);
      if (changingViewSuccess == false)
        print("Can't change view !");
    }
    else {
      if (errorMessage != null)
        print("Authentication failure : $errorMessage");
      else
        print("Authentication failure");
    }
  }
  _attemptLogin({@required BuildContext context, @required String mail, @required String pass}) {
    _model.signIn(mail, pass, (value, message) => this._onSignInResult(context, value, message));
  }
}

import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignInPageModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:flutter/material.dart';


class SignInPageViewModel extends AViewModel {
  SignInPageModel _model;
  SignInPageViewModel() : super(Routes.signInPage) {
    this._model = super.abstractModel;
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignInPageModel get model => this._model;
  void attemptLogin() {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (formKey.currentState.validate()) {
      // If the form is valid, we want to show a Snackbar
      //Scaffold.of(context)
      //   .showSnackBar(SnackBar(content: Text('Processing Data')));
      _attemptLogin();
    }
  }
  _attemptLogin() {
    print('login');
  }
}

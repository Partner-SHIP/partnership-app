import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignInPageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignInPageViewModel extends AViewModel {
  SignInPageModel                 _model;
  Firestore                       _firestore = Firestore.instance;
  SignInPageModel get model => this._model;

  SignInPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  Future<bool> signInAction(SignInData inputs) {
    Future<bool> ret = this.signIn(email: inputs.email, password: inputs.password).then((result){
      if (result != null){
        return true;
      }
      else
        return false;
    });
    return ret;
  }

  void afterSignIn(BuildContext context) {
    this.changeView(
      route:"/home_page",
      widgetContext: context,
      popStack: true
    );
    print("LE NOUVEAU TOKEN UPDATE : ["+this.getToken()+"]");
    this._firestore.collection('profiles').document(this.loggedInUser().uid).updateData({'token':this.getToken()});
  }
}

class SignInData {
  String email = '';
  String password = '';
}
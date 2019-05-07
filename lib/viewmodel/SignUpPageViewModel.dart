import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/utils/FBCollections.dart';
import 'package:partnership/utils/PayloadsFactory.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpPageViewModel extends AViewModel {
  SignUpPageModel                 _model;
  SignUpPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  SignUpPageModel get model => this._model;

  Future<bool> signUpAction(SignUpData inputs){
    Future<bool> ret = this.signUp(email: inputs.email, password: inputs.password).then((value) {
      return (value == null);
    });
    return (ret);
  }
}

class SignUpData {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}
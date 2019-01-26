import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/utils/FBCollections.dart';
import 'package:partnership/utils/PayloadsFactory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpPageViewModel extends AViewModel {
  SignUpPageModel                 _model;
  SignUpPageViewModel(): super(Routes.signUpPage){
    this._model = super.abstractModel;
  }
  SignUpPageModel get model => this._model;

  Future<bool> signUpAction(SignUpData inputs){
    Future<bool> ret = this.signUp(email: inputs.email, password: inputs.password).then((result){
      if (result != null){
        MembershipPayload mData = this.model.createPayload(FBCollections.membership);
        ProfilePayload pData = this.model.createPayload(FBCollections.profiles);
        Timestamp timestamp = Timestamp.fromDate(DateTime.now());
        mData.lastConnection = timestamp;
        mData.lastActivity = timestamp;
        mData.dateOfMembership = timestamp;
        mData.isGroupAdmin = false;
        mData.uid = result.uid;
        pData.locationPrivacyLevel = 0;
        pData.profilePrivacyLevel = 0;
        pData.nickname = inputs.nickname;
        pData.registrationDate = timestamp;
        pData.uid = result.uid;
        this.model.pushPayload(FBCollections.membership, result.uid, mData);
        this.model.pushPayload(FBCollections.profiles, result.uid, pData);
        return true;
      }
      else
        return false;
    });
    return ret;
  }
}

class SignUpData {
  String nickname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}
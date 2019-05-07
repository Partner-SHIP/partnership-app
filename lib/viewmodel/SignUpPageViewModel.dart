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
    Future<bool> ret = this.signUp(email: inputs.email, password: inputs.password).then((result){
      if (result != null){
        MembershipPayload mData = this.model.createPayload(FBCollections.membership);
        ProfilePayload pData = this.model.createPayload(FBCollections.profiles);
        Timestamp timestamp = Timestamp.fromDate(DateTime.now());
        mData.lastConnection = Tuple2<Timestamp, PayloadAction>(timestamp, PayloadAction.WRITE);
        mData.lastActivity = Tuple2<Timestamp, PayloadAction>(timestamp, PayloadAction.WRITE);
        mData.dateOfMembership = Tuple2<Timestamp, PayloadAction>(timestamp, PayloadAction.WRITE);
        mData.isGroupAdmin = Tuple2<bool, PayloadAction>(false, PayloadAction.WRITE);
        mData.uid = Tuple2<String, PayloadAction>(result.uid, PayloadAction.WRITE);
        pData.locationPrivacyLevel = Tuple2<int, PayloadAction>(0, PayloadAction.WRITE);
        pData.profilePrivacyLevel = Tuple2<int, PayloadAction>(0, PayloadAction.WRITE);
        pData.nickname = Tuple2<String, PayloadAction>(inputs.nickname, PayloadAction.WRITE);
        pData.registrationDate = Tuple2<Timestamp, PayloadAction>(timestamp, PayloadAction.WRITE);
        pData.uid = Tuple2<String, PayloadAction>(result.uid, PayloadAction.WRITE);
        this.model.pushPayload(collection: FBCollections.membership, payload: mData, documentID: result.uid);
        this.model.pushPayload(collection: FBCollections.profiles, payload: pData, documentID: result.uid);
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
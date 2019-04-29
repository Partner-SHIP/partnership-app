import 'dart:io';
import 'package:tuple/tuple.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';
import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/utils/PayloadsFactory.dart';
import 'package:partnership/utils/FBCollections.dart';

class ProfilePageViewModel extends AViewModel {
  ProfilePageModel                  _model;
  ProfilePageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  ProfilePageModel get model => this._model;
  //////////////////GETTERS
  String get name => this.model.name;
  String get location => this.model.location;
  String get studies => this.model.studies;
  String get workLocation => this.model.workLocation;
  String get job => this.model.job;
  String get photoUrl => this.model.photoUrl;
  String get backgroundUrl => this.model.backgroundUrl;
  //////////////////
  updateProfileInformations(List<String> data, File image){
    ProfilePayload payload = this.model.createPayload(FBCollections.profiles);
    payload.firstName = Tuple2<String, PayloadAction>(data[0], PayloadAction.WRITE);
    payload.lastName = Tuple2<String, PayloadAction>(data[0], PayloadAction.WRITE);
    //payload.location = Tuple2<GeoPoint, PayloadAction>(data[1], PayloadAction.WRITE);
    //payload.studiesLocation = Tuple2<GeoPoint, PayloadAction>(data[2], PayloadAction.WRITE);
    //payload.workLocation = Tuple2<GeoPoint, PayloadAction>(data[3], PayloadAction.WRITE);
    payload.job = Tuple2<String, PayloadAction>(data[4], PayloadAction.WRITE);
    if (image != null)
      {
        // Upload image on storage
        // Get the URL and add it to payload
      }
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class ProfilePageModel extends AModel {
  ProfilePageModel(): super();
  String _firstName = 'Tom';
  String _lastName = 'Cruise';
  int _date = 1552386069;
  String _location = 'New-York';
  String _studies = 'Harvard';
  String _workLocation = 'Holywood Entertainment';
  String _job = "famous comedian";
  String _photoUrl = 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';
  String _backgroundUrl = 'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/bubble_texture.jpg?alt=media&token=b4997ecc-dd26-418a-b0a1-20881216995c';
  //////////////////GETTERS
  int get date => this._date;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get location => this._location;
  String get studies => this._studies;
  String get workLocation => this._workLocation;
  String get job => this._job;
  String get photoUrl => this._photoUrl;
  String get backgroundUrl => this._backgroundUrl;
  ///////////////////
/*
  /////////////////SETTERS
  set setName(String data) => this._name = data;
  set setLocation(String data) => this._location = data;
  set setStudies(String data) => this._studies = data;
  set setWorkLocation(String data) => this._workLocation = data;
  set setJob(String data) => this._job = data;
  set setImageFile(File data) => this._imagePickerFile = data;
  set setPhotoUrl(NetworkImage data) => this._photoUrl = data;
  //set setBackground(AssetImage data) => this.background = data;
//////////////////
*/

  void _updateProfile(Map<String, dynamic> json, Function handler){
    handler(json);
  }

  void getUserProfile({Function handler, @required String uid}){
    Map<String, String> header = {};
    Map<String, String> args = {};
    if (uid != null) {
      args['uid'] = uid;
      this.apiClient.getProfile(header: header, args: args, onSuccess: null, onError: null)
          .then((json) => (json != null) ? this._updateProfile(json as Map<String, dynamic>, handler) : print("network error"));
    }
  }
}

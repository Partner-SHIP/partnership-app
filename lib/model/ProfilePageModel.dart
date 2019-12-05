import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class ProfilePageModel extends AModel {
  ProfilePageModel(): super();
  String _firstName = '';
  String _lastName = '';
  int _date = 0;
  String _location = '';
  String _studies = '';
  String _workLocation = '';
  String _job = "";
  String _photoUrl = '';
  String _backgroundUrl = '';
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
          .then((json) {
            (json != null) ? this._updateProfile(json[0] as Map<String, dynamic>, handler) : print("network error");
            final StorageReference storageReference = FirebaseStorage().ref().child("profiles/" + uid + "/photo_de_profile");
          });
    }
  }

  void postProfile(String uid, Map<String, String> args, Function handler, File imagePickerFile){
    this.apiClient.postProfile(header: <String, String>{'uid':uid}, args: args).then((_) {
      print("OKKKK22222222222");
      final StorageReference storageReference = FirebaseStorage().ref().child('profiles/$uid/photo_de_profile');
      StorageUploadTask uploadTask = storageReference.putFile(imagePickerFile);
      //storageReference.getDownloadURL().
      this.getUserProfile(uid: uid, handler: handler);
    });
  }
}

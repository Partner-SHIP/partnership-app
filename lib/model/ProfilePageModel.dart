import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class ProfilePageModel extends AModel {
  ProfilePageModel(): super(const <String>[FBCollections.profiles, FBCollections.projects/*Collections needed here*/]);
  String _name;
  String _location;
  String _studies;
  String _workLocation;
  String _job;
  File _imagePickerFile;
  NetworkImage    _photoUrl;
  //AssetImage      background = AssetImage('assets/blue_texture.jpg');
  //////////////////GETTERS
  String get name => this._name;
  String get location => this._location;
  String get studies => this._studies;
  String get workLocation => this._workLocation;
  String get job => this._job;
  NetworkImage get photoUrl => this._photoUrl;
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
}
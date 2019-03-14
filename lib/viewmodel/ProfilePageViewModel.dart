import 'dart:io';

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
  String name = 'Tom Cruise';
  String location = 'New-York';
  String studies = 'Harvard';
  String workLocation = 'Holywood Entertainment';
  String job = "famous comedian";
  File imagePickerFile;
  NetworkImage    networkImage = NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg');
  AssetImage      background = AssetImage('assets/blue_texture.jpg');
  /////////////////SETTERS
  set setName(String data) => this.name = data;
  set setLocation(String data) => this.location = data;
  set setStudies(String data) => this.studies = data;
  set setWorkLocation(String data) => this.workLocation = data;
  set setJob(String data) => this.job = data;
  set setImageFile(File data) => this.imagePickerFile = data;
  set setNetworkImage(NetworkImage data) => this.networkImage = data;
  set setBackground(AssetImage data) => this.background = data;
  //////////////////
  updateProfileInformations(List<String> data, File image){
    ProfilePayload payload = this.model.createPayload(FBCollections.profiles);
  }
}
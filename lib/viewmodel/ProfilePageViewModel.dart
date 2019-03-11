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
  NetworkImage    image = NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg');
  AssetImage      background = AssetImage('assets/blue_texture.jpg');
  void changeName(String _name){
    name = _name;
  }

  updateProfileInformations(List<String> data, File image){
    ProfilePayload payload = this.model.createPayload(FBCollections.profiles);
  }
}
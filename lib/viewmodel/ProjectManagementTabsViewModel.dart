import 'package:partnership/model/ProjectManagementTabsModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MemberRemove {
  MemberRemove(String name, String imgUrl)
      : name = name,
        imgUrl = imgUrl;
  String name;
  String imgUrl;
}

class MemberAccept {
  String name;
  String imgUrl;
}

class ProjectManagementTabsViewModel extends AViewModel {
  ProjectManagementTabsModel _projectModel;
  MemberRemove dummyRemove;
  MemberAccept dummyAccept;
  List<MemberRemove> dummyRemoveList = [];
  List<MemberAccept> dummyAcceptList = [];

  ProjectManagementTabsViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
    this.dummyRemove = MemberRemove('Jeff Jefferson', 'https://avatarfiles.alphacoders.com/151/151140.jpg');
    this.dummyRemoveList.add(this.dummyRemove);
    this.dummyRemoveList.add(this.dummyRemove);
  }
}

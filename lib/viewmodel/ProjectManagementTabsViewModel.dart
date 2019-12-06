import 'package:partnership/model/ProjectManagementTabsModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MemberRemove {
  MemberRemove(
      String firstName, String lastName, String pid, String uid, String imgUrl)
      : firstName = firstName,
        lastName = lastName,
        pid = pid,
        uid = uid,
        imgUrl = imgUrl;
  String firstName;
  String lastName;
  String pid;
  String uid;
  String imgUrl;
}

class MemberAccept {
  MemberAccept(
      String firstName, String lastName, String pid, String uid, String imgUrl)
      : firstName = firstName,
        lastName = lastName,
        pid = pid,
        uid = uid,
        imgUrl = imgUrl;
  String firstName;
  String lastName;
  String pid;
  String uid;
  String imgUrl;
}

class ProjectManagementTabsViewModel extends AViewModel {
  ProjectManagementTabsModel _projectModel;

  ProjectManagementTabsViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
}

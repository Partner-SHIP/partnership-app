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
  MemberAccept(String name, String imgUrl)
      : name = name,
        imgUrl = imgUrl;
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
    var dummyRemove1 = MemberRemove(
        'Jeff1',
        'Jeffius',
        "DZuqwgxqsWNP4n6zy1Y6",
        "eXAjrxnchQPCE4nPhqRMv46Cj7J2",
        'https://avatarfiles.alphacoders.com/151/151140.jpg');
    var dummyRemove2 = MemberRemove(
        'Jeff2',
        'Jeffius',
        "DZuqwgxqsWNP4n6zy1Y6",
        "eXAjrxnchQPCE4nPhqRMv46Cj7J2",
        'https://avatarfiles.alphacoders.com/151/151140.jpg');
    var dummyRemove3 = MemberRemove(
        'Jeff3',
        'Jeffius',
        "DZuqwgxqsWNP4n6zy1Y6",
        "eXAjrxnchQPCE4nPhqRMv46Cj7J2",
        'https://avatarfiles.alphacoders.com/151/151140.jpg');
    var dummyRemove4 = MemberRemove(
        'Jeff4',
        'Jeffius',
        "DZuqwgxqsWNP4n6zy1Y6",
        "eXAjrxnchQPCE4nPhqRMv46Cj7J2",
        'https://avatarfiles.alphacoders.com/151/151140.jpg');
    this.dummyRemoveList.add(dummyRemove1);
    this.dummyRemoveList.add(dummyRemove2);
    this.dummyRemoveList.add(dummyRemove3);
    this.dummyRemoveList.add(dummyRemove4);
    this.dummyAccept =
        MemberAccept('Toto titi', 'https://picsum.photos/250?image=9');
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
    this.dummyAcceptList.add(this.dummyAccept);
  }
}

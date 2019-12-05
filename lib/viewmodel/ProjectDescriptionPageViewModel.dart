import 'package:partnership/model/ProjectDescriptionPageModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class ProjectDescriptionPageViewModel extends AViewModel {
  ProjectDescriptionPageViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
  ProjectDescriptionPageModel _projectModel;
  File getBannerFile({@required String user, @required String project, @required Function onUpdate}) {
  }

  void postLike(String idProject, Function handler) {
    this._projectModel.postLike(idProject, this.loggedInUser().uid, handler);
  }
  
  void postFollow(String idProject, Function handler) {
    this._projectModel.postFollow(idProject, this.loggedInUser().uid, handler);
  }
  
   void postProjectInscription(String idProject, String message, Function handler) {
    this._projectModel.postProjectInscription(idProject, this.loggedInUser().uid, message, handler);
  }
  
  void postComment(String idProject, TextEditingController message, Function handler) {
    String msg = message.text;
    this._projectModel.postAddComment(idProject, this.loggedInUser().uid, msg, handler);
  }
  
}
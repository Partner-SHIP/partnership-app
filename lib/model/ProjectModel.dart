import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/UserPageModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class ProjectModel extends AModel {
  UserPageModel _userModel;
  ProjectModel(): super();
  
  void setUserModel({@required UserPageModel model}) {
    this._userModel = model;
  }
  void createProject({@required String name, @required Function onResult}) async {
    onResult(false, "Impossible de créer le projet $name pour le moment");
  }
}

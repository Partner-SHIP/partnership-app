import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/UserModel.dart';

class ProjectModel extends AModel {
  UserModel _userModel;
  ProjectModel();
  void setUserModel({@required UserModel model}) {
    this._userModel = model;
  }
  void createProject({@required String name, @required Function onResult}) async {
    onResult(false, "Impossible de créer le projet $name pour le moment");
  }
}

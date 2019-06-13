import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/NotificationsPageModel.dart';

class NotificationsPageViewModel extends AViewModel {
  NotificationsPageModel _model;
  NotificationsPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  NotificationsPageModel get model => this._model;

  //GETTERS//

  //

}

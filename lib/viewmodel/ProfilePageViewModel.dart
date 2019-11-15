import 'dart:io';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';

class ProfilePageViewModel extends AViewModel {
  ProfilePageModel                  _model;
  ProfilePageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  ProfilePageModel get model => this._model;
  //////////////////GETTERS
  String get firstName => this.model.firstName;
  String get lastName => this.model.lastName;
  String get location => this.model.location;
  String get studies => this.model.studies;
  String get workLocation => this.model.workLocation;
  String get job => this.model.job;
  String get photoUrl => this.model.photoUrl;
  String get backgroundUrl => this.model.backgroundUrl;
  int get date => this.model.date;
  //////////////////
  updateProfileInformations(List<String> data, File image){
    if (image != null)
      {
        // Upload image on storage
        // Get the URL and add it to payload
      }
  }

  void postProfile(Map<String, String> args, Function handler){
    this.model.postProfile(this.loggedInUser().uid, args, handler);
  }

  void getCurrentUserProfile(Function handler){
    String currentUserUid;
    var user = this.loggedInUser();
    print(this.loggedInUser());
    user != null ? currentUserUid = user.uid : currentUserUid = null;
    this.model.getUserProfile(handler: handler, uid: currentUserUid);
  }
}
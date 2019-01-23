import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';
import 'package:partnership/utils/Routes.dart';

class ProfilePageViewModel extends AViewModel {
  ProfilePageModel                  _model;
  ProfilePageViewModel() : super(Routes.profilePage){
    this._model = super.abstractModel;
  }
  ProfilePageModel get model => this._model;
}
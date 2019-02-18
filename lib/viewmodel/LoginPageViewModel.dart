import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/LoginPageModel.dart';
import 'package:partnership/utils/Routes.dart';

class LoginPageViewModel extends AViewModel {
  LoginPageModel                  _model;
  LoginPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  LoginPageModel get model => this._model;
}
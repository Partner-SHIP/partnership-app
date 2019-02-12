import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignInPageModel.dart';
import 'package:partnership/utils/Routes.dart';

class SignInPageViewModel extends AViewModel {
  SignInPageModel                 _model;
  SignInPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  SignInPageModel get model => this._model;
}
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/utils/Routes.dart';

class SignUpPageViewModel extends AViewModel {
  SignUpPageModel                 _model;
  SignUpPageViewModel(): super(Routes.signUpPage){
    this._model = super.abstractModel;
  }
  SignUpPageModel get model => this._model;
}
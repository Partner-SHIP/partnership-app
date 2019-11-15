import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/NavigPageModel.dart';

class NavigPageViewModel extends AViewModel {
  NavigPageModel _model;

  NavigPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  NavigPageModel get model => this._model;
}
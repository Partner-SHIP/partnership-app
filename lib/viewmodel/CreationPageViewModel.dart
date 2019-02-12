import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/CreationPageModel.dart';
import 'package:partnership/utils/Routes.dart';

class CreationPageViewModel extends AViewModel {
  CreationPageModel                 _model;
  CreationPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  CreationPageModel get model => this._model;
}
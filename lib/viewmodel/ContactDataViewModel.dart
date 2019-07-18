import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ContactDataModel.dart';

class ContactDataViewModel extends AViewModel {
  ContactDataModel _model;

  ContactDataViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  ContactDataModel get model => this._model;
}

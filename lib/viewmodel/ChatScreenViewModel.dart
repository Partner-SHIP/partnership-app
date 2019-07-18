import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatScreenModel.dart';

class ChatScreenViewModel extends AViewModel {
  ChatScreenModel _model;

  ChatScreenViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  ChatScreenModel get model => this._model;
}

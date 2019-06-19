import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatPageModel.dart';

class ChatPageViewModel extends AViewModel {
  ChatPageModel _model;

  ChatPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  ChatPageModel get model => this._model;
}

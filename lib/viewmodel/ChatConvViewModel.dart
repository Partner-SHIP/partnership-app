import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatConvModel.dart';

class ChatConvViewModel extends AViewModel {
  ChatConvModel _model;

  ChatConvViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  ChatConvModel get model => this._model;
}

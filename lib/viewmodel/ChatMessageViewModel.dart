import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatMessageModel.dart';

class ChatMessageViewModel extends AViewModel {
  ChatMessageModel                  _model;
  ChatMessageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  ChatMessageModel get model => this._model;
  }
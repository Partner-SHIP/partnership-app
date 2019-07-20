import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatScreenModel.dart';

class ChatScreenViewModel extends AViewModel {
  ChatScreenModel _model;

  ChatScreenViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  ChatScreenModel get model => this._model;

  String getMyConvPath() =>
      'chat/' + _model.my_id + '/conversation' + _model.contact_id;

  String getContactConvPath() =>
      'chat/' + _model.contact_id + '/conversation' + _model.my_id;

  void setMyId(String my_id) {
    _model.my_id = my_id;
  }

  void setContactId(String contact_id) {
    _model.contact_id = contact_id;
  }

  String getMyId() {
    return _model.my_id;
  }

  String getContactId() {
    return _model.contact_id;
  }

  void sendingMessages(String message) {
    if (message.isNotEmpty) {
      // _model.sendMessage(my_conv_path, my_name, message);
      // _model.sendMessage(contact_conv_path, contact_name, message);
    }
  }
}

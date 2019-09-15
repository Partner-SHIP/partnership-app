import 'package:intl/intl.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/ChatMessage.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatScreenModel.dart';

class ChatScreenViewModel extends AViewModel {
  ChatScreenModel _model;
  DateFormat dateFormat;
  Coordinator user;

  ChatScreenViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
    dateFormat = new DateFormat("dd/MM/yyyy 'à' HH:mm:ss");
    user = new Coordinator();
  }

  ChatScreenModel get model => this._model;

  void init(){
    _model.init();
    _model.contactName = null;
    _model.myId = user.getLoggedInUser().uid;
    _model.contactId = user.getContactId();
    if (_model.getMessages().isNotEmpty)
    print(_model.getMessages());
  }

  void initNames(){
    this._model.initMyName();
    this._model.initContactName();
  }

  String getContactListPath() => 'chat/' + _model.myId + '/conversations';

  String getMyConvPath() =>
      'chat/' + _model.myId + '/conversations/' + _model.contactId;

  String getContactConvPath() =>
      'chat/' + _model.contactId + '/conversations/' + _model.myId;

  void setMyId(String myId) {
    _model.myId = myId;
  }

  String getMyId() {
    return _model.myId;
  }

  String getMyName(){
    return _model.myName;
  }

  String getContactName(){
    return _model.contactName;
  }

  void setContactId(String contactId) {
    _model.contactId = contactId;
  }

  String getContactId() {
    return _model.contactId;
  }

  List<ChatMessage> getMessages() {
    return _model.getMessages();
  }

  void messagesChanges(var snapshot) {
    if (snapshot.data.data.containsValue("messages") != null) {
      List list = snapshot.data.data["messages"];
      if (list != null) var value = list.last["message"];
      if (list != null &&
          _model.getMessages().length < list.length &&
          _model.myName != null) {
        for (int i = _model.getMessages().length; i < list.length; i++) {
          DateTime dateTime = list.elementAt(i)["timestamp"].toDate();
          dateTime = dateTime.toUtc().add(new Duration(hours: 2));
          String _date = dateFormat.format(dateTime);
          _model.addMessage(list.elementAt(i)["name"].toString(),
              list.elementAt(i)["message"].toString(), _date);
        }
      }
    }
  }

  void sendingMessages(String message) {
    if (message.isNotEmpty) {
      _model.sendMessage(getMyConvPath(), message);
      _model.sendMessage(getContactConvPath(), message);
    }
  }
}

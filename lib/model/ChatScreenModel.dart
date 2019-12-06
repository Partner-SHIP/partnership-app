import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/model/AModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/ui/ChatMessage.dart';

class ChatScreenModel extends AModel {
  Coordinator user;
  String _myName;
  String _myId;
  String _contactName;
  String _contactId;
  List<ChatMessage> messages;

  ChatScreenModel() : super() {
    this.user = new Coordinator();
  }

  String get myName => this._myName;

  set myName(String name) => this._myName = name;

  void init(){
    messages = new List();
  }

  void  initMyName(){
    Firestore.instance.document('profiles/' + this._myId).snapshots().listen((onData){
      this._myName = onData.data['firstName'];
    });
}

  String get contactName => this._contactName;

  set contactName(String name) => this._contactName = name;

  void  initContactName(){
    Firestore.instance.document('profiles/' + this._contactId).snapshots().listen((onData){
      this._contactName = onData.data['firstName'];
    });
  }

  String get myId => this._myId;

  set myId(String id) => this._myId = id;

  String get contactId => this._contactId;

  set contactId(String id) => this._contactId = id;

  void addMessage(String name, String message, String date, String uid, String myUid) {
    if (message != null && message.length > 0) {
      messages.insert(
          0,
          new ChatMessage(
            name: name,
            text: message,
            date: date,
            uid: uid,
            myUid: myUid,
          ));
    }
  }

  List<ChatMessage> getMessages() {
    return this.messages;
  }

  /*List<ChatMessage> setMessages(List<ChatMessage> message) {
    this.messages = message;
  }*/

  void sendMessage(String path_conversation, String message, String myId) {
    Firestore.instance.document(path_conversation).setData({
      'messages': FieldValue.arrayUnion([
        {
          'name': myName,
          'message': message,
          'timestamp': DateTime.now(),
          'uid' : myId,
          'hasSeen': false
        }
      ])
    }, merge: true);
  }
}

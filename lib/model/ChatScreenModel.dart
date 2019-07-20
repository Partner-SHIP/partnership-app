import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/model/AModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenModel extends AModel {
  Coordinator user;

  String get my_name => this.my_name;

  String get contact_name => this.contact_name;

  String get my_id => this.user.getLoggedInUser().uid;

  String get contact_id => this.contact_id;

  ChatScreenModel() : super() {
    this.user = new Coordinator();
  }

  set my_name(String my_name) => this.my_name = my_name;

  set contact_name(String _contact_name) => this.contact_name = _contact_name;

  set my_id(String my_id) => this.my_id = my_id;

  set contact_id(String _contact_id) => this.contact_id = _contact_id;

  void sendMessage(String path_conversation, String name, String message) {
    Firestore.instance.document(path_conversation).setData({
      'messages': FieldValue.arrayUnion([
        {
          'name': name,
          'message': message,
          'timestamp': DateTime.now(),
          'hasSeen': false
        }
      ])
    }, merge: true);
  }
}

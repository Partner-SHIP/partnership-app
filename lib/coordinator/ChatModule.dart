import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IChat {
  String getContactId();
  void setContactId(String contactId);
}

class ChatModule implements IChat {
  static final ChatModule _instance = ChatModule._internal();
  String contactId;

  factory ChatModule() {
    return _instance;
  }

  ChatModule._internal();

  @override
  String getContactId() {
    return contactId;
  }

  @override
  void setContactId(String contactId) {
    this.contactId = contactId;
  }
}

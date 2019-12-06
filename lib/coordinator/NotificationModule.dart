import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';

import 'package:tuple/tuple.dart';

abstract class INotification {
  void initializeNotificationModule();
  StreamSubscription subscribeToNotification(Function handler);
  String getToken();
}

enum EnumNotification {
  PROJECT_CREATION_NOTIFICATION,
  PROJECT_DELETE_NOTIFICATION,
  PROJECT_JOINED_NOTIFICATION,
  PROJECT_LEAVED_NOTIFICATION,
  CONTACT_ADD_NOTIFICATION,
  PROJECT_COMMENT_ADD_NOTIFICATION,
  MESSAGE_NOTIFICATION
}

class NotificationModule implements INotification {
  static final NotificationModule _instance = NotificationModule._internal();
  bool titi = false;
  String token = "";
  factory NotificationModule() {
    return _instance;
  }
  NotificationModule._internal();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  // ignore: close_sinks
  StreamController<Map<String, dynamic>> _notificationController
                              = StreamController<Map<String, dynamic>>();
  void _initialize() {
    firebaseMessaging.getToken().then((token){
      print("YOLO JAI LE TOKEN : ["+token+"]");
      this.token = token;
    });
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        print("onLaunch called");
        msg.forEach((k, v){
          print(k+" : "+v.toString());
        });
        _notificationController.add(msg);
      },
      onResume: (Map<String, dynamic> msg) async {
        print("onResume called");
        msg.forEach((k, v){
          print(k+" : "+v.toString());
        });
        _notificationController.add(msg);
      },
      onMessage: (Map<String, dynamic> msg) async {
        print("onMessage called");
        msg.forEach((k, v){
          print(k+" : "+v.toString());
        });
        _notificationController.add(msg);
      }
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){
      print ('IOS Setting Registed');
    });
  }

  @override
  void initializeNotificationModule() {
    this._initialize();
  }

  @override
  StreamSubscription subscribeToNotification(Function handler) {
    return _notificationController.stream.listen(handler);
  }

  @override
  String getToken() {
    return this.token;
  }
}


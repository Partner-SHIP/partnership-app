import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';

abstract class INotification {
  void initializeNotificationModule();
  StreamSubscription subscribeToNotification(Function handler);
}

enum EnumNotification {
  NOTIFICATION_MESSAGE,
  NOTIFICATION_LAUNCH,
  NOTIFICATION_RESUME
}

class NotificationModule implements INotification {
  static final NotificationModule _instance = NotificationModule._internal();
  bool titi = false;
  factory NotificationModule() {
    return _instance;
  }
  NotificationModule._internal();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  StreamController<EnumNotification> _notificationController = StreamController<EnumNotification>();
  void _initialize() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        print("onLaunch called");
        _notificationController.add(EnumNotification.NOTIFICATION_LAUNCH);
      },
      onResume: (Map<String, dynamic> msg) async {
        print("onResume called");
        //_notificationController.add(EnumNotification.NOTIFICATION_RESUME);
      },
      onMessage: (Map<String, dynamic> msg) async {
        print("onMessage called");
        print(_notificationController.hasListener);
        _notificationController.add(EnumNotification.NOTIFICATION_MESSAGE);

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
    firebaseMessaging.getToken().then((token){
      update(token);
    });
  }

  void update(String token) {
    print("token : ["+token+"]");
  }

  @override
  void initializeNotificationModule() {
    this._initialize();
  }

  @override
  StreamSubscription subscribeToNotification(Function handler) {
    return _notificationController.stream.listen(handler);
  }
}


import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationModule {
  static final NotificationModule instance = NotificationModule._internal();
  factory NotificationModule() {
    return instance;
  }
  NotificationModule._internal();

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  String textValue = 'Hello World !';

  void initialize() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLaunch called");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("onMessage called");
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
    print(token);
    textValue = token;
  }
}


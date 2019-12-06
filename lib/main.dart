import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //ApplicationSwitcherDescription description = ApplicationSwitcherDescription(label:'LOL', primaryColor: 0xff502e54);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //SystemChrome.setApplicationSwitcherDescription(description).then((_){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
      runApp(new PartnershipApp());
    });
  //});
}
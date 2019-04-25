import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  // Timestamp replaces Dates, Persistence for offline use
  Firestore.instance.settings(
      timestampsInSnapshotsEnabled: true,
      persistenceEnabled: true
  );
  //ApplicationSwitcherDescription description = ApplicationSwitcherDescription(label:'LOL', primaryColor: 0xff502e54);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //SystemChrome.setApplicationSwitcherDescription(description).then((_){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
      runApp(new PartnershipApp());
    });
  //});
}
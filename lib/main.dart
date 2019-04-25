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
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new PartnershipApp());
  });
}
import 'package:flutter/material.dart';
import 'package:partnership/coordinator/COORDINATOR.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  // Timestamp replaces Dates, Persistence for offline use
  Firestore.instance.settings(
      timestampsInSnapshotsEnabled: true,
      persistenceEnabled: true
  );
  runApp(new PartnershipApp());
}
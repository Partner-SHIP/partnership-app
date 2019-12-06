import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'AREST.dart';

abstract class AModel implements AModelFactory{
  final IApiREST apiClient = ApiREST();
  Firestore      firestore = Firestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  AModel();
}
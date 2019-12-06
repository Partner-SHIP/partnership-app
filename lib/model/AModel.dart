import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'AREST.dart';

abstract class AModel implements AModelFactory{
  final IApiREST apiClient = ApiREST();
  Firestore      firestore = Firestore.instance;
  AModel();
}
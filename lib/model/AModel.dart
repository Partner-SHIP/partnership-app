import 'dart:async';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/model/FBStreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'package:partnership/utils/PayloadsFactory.dart';
import 'package:partnership/utils/FBCollections.dart';

abstract class AModel implements AModelFactory{
  final Firestore                                                               _firestore = Firestore.instance;
  final Map<String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>> _streamWrappers = <String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>>{};
  List<String>                                                                  _collections;

  Map<String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>> get streamWrapper => this._streamWrappers;

  AModel(List<String> collections){
    try {
      assert(collections != null && collections.length > 0, "No firebase collections provided to initialize model");
      this._collections = collections;
      this._collections.forEach((collection) {
        this._streamWrappers[collection] = Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>(null, null);
      });
    }
    catch(error){

    }
  }
  bool _assertCollection(String collection){
    try {
      assert(this._collections.contains(collection), "This model wasn't initialized to use the collection: "+collection);
      return true;
    }
    catch(_){
      return false;
    }
  }

  Payload createPayload(String collection){
    _assertCollection(collection);
    return (PayloadsFactory(collection));
  }
  void pushPayload(String collection, String uid, Payload payload){
      this._firestore.collection(collection).document(uid).setData(payload.getPayload());
  }
}


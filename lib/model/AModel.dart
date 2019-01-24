import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/utils/FBCollections.dart';
import 'package:partnership/model/FBStreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';

abstract class AModel implements AModelFactory{
  final Map<String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>> _streamWrappers = <String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>>{};
  List<String>                                                                  _collections;

  AModel(List<String> collections){
    try {
      assert(collections != null && collections.length > 0, "No firebase collections provided to initialize model");
      this._collections = collections;
      this._collections.forEach((collection) {

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
  Map<String, Tuple2<FBStreamWrapper, StreamSubscription<QuerySnapshot>>> get streamWrapper => this._streamWrappers;
}


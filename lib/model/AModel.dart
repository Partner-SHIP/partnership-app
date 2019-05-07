import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/model/StreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'package:partnership/utils/PayloadsFactory.dart';

abstract class AModel implements AModelFactory{
  final Firestore                                                               _firestore = Firestore.instance;
  final Map<String, Tuple2<StreamWrapper, StreamSubscription<QuerySnapshot>>> _streamWrappers = <String, Tuple2<StreamWrapper, StreamSubscription<QuerySnapshot>>>{};
  List<String>                                                                  _collections;

  Map<String, Tuple2<StreamWrapper, StreamSubscription<QuerySnapshot>>> get streamWrapper => this._streamWrappers;

  AModel(List<String> collections){
    try {
      assert(collections != null && collections.length > 0, "No firebase collections provided to initialize model");
      this._collections = collections;
      this._collections.forEach((collection) {
        this._streamWrappers[collection] = Tuple2<StreamWrapper, StreamSubscription<QuerySnapshot>>(null, null);
      });
    }
    catch(error){
      print(error);
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

  StreamWrapper createStreamWrapper({@required String id, @required Stream stream, @required Function listenCallback, @required Function pauseCallback, @required Function resumeCallback, @required Function cancelCallback}){
    if (this._streamWrappers[id].item1 != null) {
        if (this._streamWrappers[id].item2 != null)
          this._streamWrappers[id].item2.cancel().then((_) => this._streamWrappers[id].withItem2(null));
        this._streamWrappers[id].withItem1(null);
      }
    this._streamWrappers[id].withItem1(StreamWrapper(
        stream: stream,
        listenCallback: listenCallback,
        pauseCallback: pauseCallback,
        resumeCallback: resumeCallback,
        cancelCallback: cancelCallback));
    return this._streamWrappers[id].item1;
  }

  void deleteDocument({@required String collection, DocumentReference documentRef, String documentID}){
    _assertCollection(collection);
    try {
      if (documentRef != null) {
        documentRef.delete();
        return;
      }
      if (documentID != null){
        this._firestore.collection(collection).document(documentID).delete();
        return;
      }
    } catch (error){
      print(error);
    }
  }

  Payload createPayload(String collection){
    _assertCollection(collection);
    return (PayloadsFactory(collection));
  }
  void pushPayload({@required String collection, @required Payload payload, String documentID}){
    _assertCollection(collection);
    var dataToWrite = payload.getDataToWrite();
    var dataToUpdate = payload.getDataToUpdate();
    if (dataToWrite.isNotEmpty){
      documentID != null && documentID.isNotEmpty ?
      this._firestore.collection(collection).document(documentID).setData(dataToWrite) :
      this._firestore.collection(collection).document().setData(dataToWrite);
    }
    if (dataToUpdate.isNotEmpty){
      documentID != null && documentID.isNotEmpty ?
      this._firestore.collection(collection).document(documentID).updateData(dataToUpdate) :
      this._firestore.collection(collection).document().updateData(dataToUpdate);
    }
  }
}
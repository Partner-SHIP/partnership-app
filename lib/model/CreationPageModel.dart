import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:partnership/model/AModel.dart';

class CreationPageModel extends AModel {
  CreationPageModel() : super();
  bool posting = false;

  void _postProjectRequests(String name, String description, File image, File logo, String uid, Function handler) {
    print('POST PROJECT UID : $uid');
    Map<String, String> args = {
      'name':name,
      'description':description,
    };
    Map<String, String> header = {
      'uid':uid
    };
    this.storage.ref().child('projects/').child(DateTime.now().toIso8601String()).putFile(logo).onComplete.then((StorageTaskSnapshot snapshot){
      snapshot.ref.getDownloadURL().then((url){
        args["logoPath"] = Uri.encodeComponent(url);
        this.storage.ref().child("projects/").child(DateTime.now().toIso8601String()).putFile(image).onComplete.then((StorageTaskSnapshot snapshot){
          snapshot.ref.getDownloadURL().then((url){
            args["bannerPath"] = Uri.encodeComponent(url);
            print("URL IMAGE UPLOAD = ["+args["bannerPath"]+"]");
            this.apiClient.postProject(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
              handler(value);
            });
          });
        });
      });
    });
  }

  void onSuccess(Object obj) {
    print("SUCCESS POST PROJECT");
  }

  void onError() {
    print("ERROR POST PROJECT");
}

  void _cantPost() {
    posting = false;
  }
  void _postedProject(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }
  void postProject(String name, String description, File image, File logo, String uid, Function handler){
    if (posting == true)
      return ;
    posting = true;
    _postProjectRequests(name, description, image, logo, uid, handler);
  }
}

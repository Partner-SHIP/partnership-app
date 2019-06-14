import 'dart:convert';
import 'dart:io';

import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';
import 'package:partnership/model/AREST.dart';

class CreationPageModel extends AModel {
  CreationPageModel() : super();
  bool posting = false;

  void _postProjectRequests(String name, String description, File image, String uid) {

    print('POST PROJECT UID : $uid');
    Map<String, String> args = {
      'name':name,
      'description':description
    };
    Map<String, String> header = {
      'uid':uid
    };
    this.apiClient.postProject(header: header, args: args).then((value)=> print(value));
    /*

    AREST WAS CHANGED !!!!

    String path = await AREST.publishFile(user:"user", file:image);
    var head = Map<String, String>();
    head["name"] = name;
    head["description"] = description;
    head["logoPath"] = path;
    head["bannerPath"] = path;
    head["user"] = "projectadmin";
    AREST.httpsPostRequest(
      header: head,
      path:"https://us-central1-partnership-app-e8d99.cloudfunctions.net/postProject",
      onSuccess: (body) {print("==============================\n===================\n==============\n=====\nsucces $body");_postedProject(body);},
      onError: (body) => _cantPost(),
    );
    */
  }

  void _cantPost() {
    posting = false;
  }
  void _postedProject(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }
  void postProject(String name, String description, File image, String uid){
    if (posting == true)
      return ;
    posting = true;
    _postProjectRequests(name, description, image, uid);
  }
}

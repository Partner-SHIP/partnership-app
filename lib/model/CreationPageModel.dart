import 'dart:convert';
import 'dart:io';
import 'package:partnership/model/AModel.dart';

class CreationPageModel extends AModel {
  CreationPageModel() : super();
  bool posting = false;

  void _postProjectRequests(String name, String description, File image, String uid, Function handler) {
    print('POST PROJECT UID : $uid');
    Map<String, String> args = {
      'name':name,
      'description':description,
    };
    Map<String, String> header = {
      'uid':uid
    };
    this.apiClient.postProject(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      print("VALUE CREATION PROJET :"+value.toString());
      handler(value);
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
  void postProject(String name, String description, File image, String uid, Function handler){
    if (posting == true)
      return ;
    posting = true;
    _postProjectRequests(name, description, image, uid, handler);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:partnership/model/AModel.dart';

class ProjectDescriptionPageModel extends AModel {
  ProjectDescriptionPageModel(): super();
  
  bool adding = false;
  bool following = false;

  void _addLikeRequests(String pid, String uid, Function handler) {
    print('ADD LIKE BY : $uid');
    Map<String, String> args = {
      'projectUid':pid,
      'uid':uid,
    };
    Map<String, String> header ={
      'Like':uid
    };

    this.apiClient.addLike(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  

  void onSuccess(){
    print("SUCCESS");
  }

  void onError(){
    print("ERROR");
  }

  void cantAddLike() {
    adding = false;
  }
  
  void addedLike(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void addLike(String pid, String uid, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _addLikeRequests(pid, uid, handler);
  }

  void _addFollowRequests(String pid, String uid, Function handler) {
    print('ADD FOLLOW BY : $uid');
    Map<String, String> args = {
      'projectUid':pid,
      'uid':uid,
    };
    Map<String, String> header ={
      'Follow':uid
    };

    this.apiClient.addFollow(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  void cantAddFollow() {
    adding = false;
  }
  
  void addedFollow(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void addFollow(String pid, String uid, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _addFollowRequests(pid, uid, handler);
  }
}
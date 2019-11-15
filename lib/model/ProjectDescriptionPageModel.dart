import 'dart:convert';
import 'dart:io';
import 'package:partnership/model/AModel.dart';

class ProjectDescriptionPageModel extends AModel {
  ProjectDescriptionPageModel(): super();
  
  bool adding = false;

  void _addLikeRequests(String pid, String uid, Function handler) {
    print('ADD LIKE BY : $uid');
    Map<String, String> args = {
      'pid':pid,
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
    print("SUCCESS ADD LIKE");
  }

  void onError(){
    print("ERROR ADD LIKE");
  }

  void _cantAddLike() {
    adding = false;
  }
  
  void _addedLike(String result) {
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
}
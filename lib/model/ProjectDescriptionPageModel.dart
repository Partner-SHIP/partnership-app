import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:partnership/model/AModel.dart';

class ProjectDescriptionPageModel extends AModel {
  ProjectDescriptionPageModel(): super();
  
  bool adding = false;
  bool following = false;

  //////////////////////////////////////Like///////////////////////////////////////////////////

  void _postLikeRequests(String pid, String uid, Function handler) {
    print('ADD LIKE BY : $uid');
    Map<String, String> args = {
      'projectUid':pid,
      'uid':uid,
    };
    Map<String, String> header ={
      'Like':uid
    };

    this.apiClient.postLike(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  

  void onSuccess(){
    print("SUCCESS");
  }

  void onError(){
    print("ERROR");
  }

  void cantPostLike() {
    adding = false;
  }
  
  void postedLike(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void postLike(String pid, String uid, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _postLikeRequests(pid, uid, handler);
  }

  ////////////////////////////////////Follow//////////////////////////////////////////////

  void _postFollowRequests(String pid, String uid, Function handler) {
    print('ADD FOLLOW BY : $uid');
    Map<String, String> args = {
      'projectUid':pid,
      'uid':uid,
    };
    Map<String, String> header ={
      'Follow':uid
    };

    this.apiClient.postFollow(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  void cantPostFollow() {
    adding = false;
  }
  
  void postedFollow(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void postFollow(String pid, String uid, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _postFollowRequests(pid, uid, handler);
  }

  /////////////////////////////////////Project Inscription////////////////////////////////////////////////////
  
  void _postProjectInscriptionRequests(String pid, String uid, String message, Function handler) {
    print('INSCRIPTION FOR : $uid');
    Map<String, String> args = {
      'uid':uid,
      'pid':pid,
      'message' :message,
    };
    Map<String, String> header ={
      'InscriptionProject':uid
    };

    this.apiClient.postProjectInscription(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  void cantPostProjectInscription() {
    adding = false;
  }
  
  void postedProjectInscription(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void postProjectInscription(String pid, String uid, String message, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _postProjectInscriptionRequests(pid, uid, message, handler);
  }

    /////////////////////////////////////Adding a comment////////////////////////////////////////////////////
void _postAddCommentRequest(String pid, String uid, String message, Function handler) {
    print('ADDING COMMENT OF : $uid');
    Map<String, String> args = {
      'uid':uid,
      'pid':pid,
      'message' :message,
    };
    Map<String, String> header ={
      'AddCommentaire':uid
    };

    this.apiClient.postComment(header: header, args: args, onSuccess: onSuccess, onError: onError).then((value){
      handler(value);
    });
  }
  void cantPostAddComment() {
    adding = false;
  }
  
  void postedAddComment(String result) {
    Map body = jsonDecode(result);
    if (body["value"] != null)
      print("success");
  }

  void postAddComment(String pid, String uid, String message, Function handler){
    if (adding == true)
      return ;
    adding = true;
    _postAddCommentRequest(pid, uid, message, handler);
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class ApiRoutes {
  static const String postComment = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/addCommentaire";
  static const String postFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Follow";
  static const String postLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Like";
  static const String postUnFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unfollow"; 
  static const String postUnLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unlike";
  static const String getProjectQueryResult = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProjectQueryResult";
  static const String getProjects = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProjects";
  static const String getStories = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getStories";
  static const String getProfile = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProfile2";
  static const String helloWorld = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/helloWorld";
  static const String postProjectInscription = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/InscriptionProject";
  static const String postProfile = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/postProfiles";
  static const String postProject = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/postProject2";
  static const String addLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Like";
  static const String addTag = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/addTag";
  static const String deleteLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unlike";
  static const String addFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Follow";
  static const String deleteFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unfollow";
  static const String addContact = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/addContact";
  static const String deleteContact = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/deleteContact";
  static const String getContact = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getContact";
  static const String getProjectByName = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProjectByName";
  static const String sendNewNotification = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/sendNewNotification";
  static const String inscriptionProjet = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/InscriptionProjet";
  static const String getDemandeProjet = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getDemandeProjet";
  static const String postResponseMemberProject = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/ReponseMembreProject";
}

abstract class IApiREST {
  Future<dynamic> postComment({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postUnFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});  
  Future<dynamic> postUnLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> getProfile({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> getProjectQueryResult({@required Map<String, String> header, Function onSuccess, Function onError});
  Future<dynamic> getStories({@required Map<String, String> header, Function onSuccess, Function onError});
  Future<dynamic> getProjects({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postProfile({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postProject({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addTag({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> deleteLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addContact({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> deleteFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> deleteContact({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> getContact({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> getProjectByName({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> sendNewNotification({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> inscriptionProjet({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> getDemandeProjet({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postProjectInscription({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postResponseMemberProject({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
}

class ApiREST implements IApiREST {
  Future<dynamic> _httpGetRequest({@required String path, @required Map<String, String> header, Function onSuccess, Function onError}) async {
    if (!header.containsKey("Accept"))
      header["Accept"] = "application/json";
    final response = await http.get(Uri.encodeFull(path), headers: header);
    if (response.statusCode == 200) {
      if (onSuccess != null)
        onSuccess(json.decode(response.body));
      return json.decode(response.body);
    }
    else if (onError != null) {
      onError(json.decode(response.body));
    }
    return null;
  }

  Future<dynamic> _httpPostRequest({@required String path, @required Map<String, String> header, Function onSuccess, Function onError}) async {
    print('REQUEST LAUNCHED');
    final response = await http.post(Uri.encodeFull(path), headers: header);
    print(response.body);
    if (response.statusCode == 200){
      if (onSuccess != null)
        onSuccess(json.decode(response.body));
      return true;
    }
    else if (onError != null)
      onError(json.decode(response.body));
    return false;
  }

  String _formatParameters(Map<String, String> args) {
    String parameters = '?';
    args.forEach((String key, String value) => parameters += (key+'='+value+'&'));
    parameters = parameters.substring(0, parameters.length - 1);
    return parameters;
  }
  
  @override
  Future<dynamic> getProjectQueryResult({Map<String, String> header, Function onSuccess, Function onError}) {
    return _httpGetRequest(path: ApiRoutes.getProjectQueryResult, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future<dynamic> getStories({Map<String, String> header, Function onSuccess, Function onError}) {
    return _httpGetRequest(path: ApiRoutes.getStories, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future<dynamic> getProfile
      (
        {
          @required Map<String, String> header,
          @required Map<String, String> args,
          Function onSuccess,
          Function onError
        }
      )
  {
    if (args.length > 0)
      return _httpGetRequest(path: ApiRoutes.getProfile+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
    return _httpGetRequest(path: ApiRoutes.getProfile, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future<dynamic> postProfile({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.postProfile+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future<dynamic> postProject({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.postProject+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.postProject+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future<dynamic> postLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.postLike+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.postLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  
  @override
  Future<dynamic> deleteLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.deleteLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> addFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.addFollow+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> deleteFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.deleteFollow+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future getProjects({Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError}) {
    // PID or empty
    if (args.length > 0)
      return _httpGetRequest(path: ApiRoutes.getProjects+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
    return _httpGetRequest(path: ApiRoutes.getProjects, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future addTag({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // PID ET TAG
    return _httpPostRequest(
        path: ApiRoutes.addTag + this._formatParameters(args),
        header: header,
        onSuccess: onSuccess,
        onError: onError);
  }
  @override
  Future<dynamic> postUnLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.postLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> postFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.postFollow+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.postFollow+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> postUnFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.postUnFollow+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  
  @override
  Future<dynamic> postProjectInscription({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.postProjectInscription+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.postProjectInscription+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
   
  @override
  Future<dynamic> postComment({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.postComment+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.postComment+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future addContact({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // UID ET UID(contact)
    return _httpPostRequest(path: ApiRoutes.addContact+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future deleteContact({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // UID ET UID(contact)
    return _httpPostRequest(path: ApiRoutes.deleteContact+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future getContact({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // UID
    if (args.length > 0)
      return _httpGetRequest(path: ApiRoutes.getContact+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
    return _httpGetRequest(path: ApiRoutes.getContact, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future getProjectByName({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // Project Name
    if (args.length > 0)
      return _httpGetRequest(path: ApiRoutes.getProjectByName+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
    return _httpGetRequest(path: ApiRoutes.getProjectByName, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future sendNewNotification({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // TOKEN, TITLE, BODY
    return _httpPostRequest(path: ApiRoutes.sendNewNotification+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future inscriptionProjet({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // PID
    return _httpPostRequest(path: ApiRoutes.inscriptionProjet+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future getDemandeProjet({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // PID
    if (args.length > 0)
      return _httpGetRequest(path: ApiRoutes.getDemandeProjet+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
    return _httpGetRequest(path: ApiRoutes.getDemandeProjet, header: header, onSuccess: onSuccess, onError: onError);
  }

  @override
  Future addLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    // PID ET TAG
    return _httpPostRequest(
        path: ApiRoutes.addLike + this._formatParameters(args),
        header: header,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future postResponseMemberProject({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.postResponseMemberProject, header: null);
  }
}

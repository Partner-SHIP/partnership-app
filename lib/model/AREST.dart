import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class ApiRoutes {
  static const String getProjectQueryResult = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProjectQueryResult";
  static const String getStories = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getStories";
  static const String helloWorld = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/helloWorld";
  static const String getProfile = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getProfile2";
  static const String postProfile = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/postProfiles";
  static const String postProject = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/postProject2";
  static const String addLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Like";
  static const String deleteLike = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unlike";
  static const String addFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Follow";
  static const String deleteFollow = "https://us-central1-partnership-app-e8d99.cloudfunctions.net/Unfollow"; 
}

abstract class IApiREST {
  Future<dynamic> getProjectQueryResult({@required Map<String, String> header, Function onSuccess, Function onError});
  Future<dynamic> getStories({@required Map<String, String> header, Function onSuccess, Function onError});
  Future<dynamic> getProfile({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postProfile({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> postProject({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> deleteLike({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> addFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});
  Future<dynamic> deleteFollow({@required Map<String, String> header, @required Map<String, String> args, Function onSuccess, Function onError});  
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
  Future<dynamic> addLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.addLike+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.addLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> deleteLike({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.addLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> addFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    print(ApiRoutes.addFollow+this._formatParameters(args));
    return _httpPostRequest(path: ApiRoutes.addLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
  @override
  Future<dynamic> deleteFollow({Map<String, String> header, Map<String, String> args, Function onSuccess, Function onError}) {
    return _httpPostRequest(path: ApiRoutes.addLike+this._formatParameters(args), header: header, onSuccess: onSuccess, onError: onError);
  }
}

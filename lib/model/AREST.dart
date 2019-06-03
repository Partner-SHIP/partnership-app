import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AREST {
  static Future<void> httpsGetRequest({@required String path, Map<String, String> header, @required Function onSuccess, @required Function onError}) async {
    if (!header.containsKey("Accept"))
      header["Accept"] = "application/json";
    final response = await http.get(Uri.encodeFull(path), headers: header);
    if (response.statusCode == 200) {
      onSuccess(response.body);
    }
    else {
      onError(response.body);
    }
  }
  static Future<void> httpsPostRequest({@required String path, Map<String, String> header, @required Function onSuccess, @required Function onError}) async {
    if (!header.containsKey("Accept"))
      header["Accept"] = "application/json";
    final response = await http.post(Uri.encodeFull(path), headers: header);
    if (response.statusCode == 200) {
      onSuccess(response.body);
    }
    else {
      onError(response.body);
    }
  }
  static Future<String> publishFile({@required String user, File file}) async {
    final uploadfilename = "users_medias" + user + basename(file.path);
    final StorageReference storageRef = FirebaseStorage.instance.ref().child(uploadfilename);
    final StorageUploadTask task = storageRef.putFile(file);
    final StorageTaskSnapshot snap = await task.onComplete;
    final String result = (await snap.ref.getDownloadURL());
    return (result);
  }
}

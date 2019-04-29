import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AREST {
  static void httpsGetRequest({@required String path, Map<String, String> header, @required Function onSuccess, @required Function onError}) async {
    http.get(path, headers: header)
    .then((onValueResult) {
      onSuccess(onValueResult);
    })
    .catchError((onErrorResult) {
      onError(onErrorResult);
    });
  }
}

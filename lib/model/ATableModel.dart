import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/AREST.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

abstract class ATableModel implements AModel {
  bool _upToDate = false;
  final int _updateDuration;
  final String _path;
  Map _requestedJSON = null;
  Map<String, String> _header;
  ATableModel({int updateDurationInSeconds = 10, @required String path, @required header}) :
    _updateDuration = updateDurationInSeconds,
    _header = header,
    _path = path
    {}
  void _handleDisupdating() async{
    Duration waitingTime = Duration(seconds: _updateDuration);
    await Future.delayed(waitingTime);
    this._upToDate = false;
  }
  bool isUpToDate() {
    return (_upToDate);
  }
  bool _getJSON() {
    bool requestSuccess;
    _requestedJSON = null;
    AREST.httpsGetRequest(
      path: _path,
      header: _header,
      onError: (onErrorResult) {
        requestSuccess = false;
      },
      onSuccess: (onSuccessResult) {
        requestSuccess = true;
        Map returnedJSON = jsonDecode(onSuccessResult.body);
        if (returnedJSON.keys.contains("error") || returnedJSON.keys.contains("Error"))
          requestSuccess = false;
        else
          _requestedJSON = returnedJSON;
      }
    );
    return (requestSuccess);
  }
  void readJSON();
  void fetch() {
    if (_upToDate == true)
      return ;
    _upToDate = _getJSON();
    if (_upToDate) {
      _handleDisupdating();
      readJSON();
    }
  }
}

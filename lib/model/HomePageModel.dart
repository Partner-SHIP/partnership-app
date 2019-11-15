import 'dart:async';
import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'StreamWrapper.dart';
import 'package:partnership/utils/FBCollections.dart';

class StoryDataModel {
  final String img_path;
  final String title;
  final String description;
  StoryDataModel({@required String img_path, @required String title, @required String description}) :
    img_path = img_path,
    title = title,
    description = description;
}

class HomePageModel extends AModel {
  List<StoryDataModel> stories = List<StoryDataModel>();
  HomePageModel();

  void _updateStories(Map<String, dynamic> json, Function handler) {
    List values = json["value"];
    stories.clear();
    values.forEach((value){
      stories.add(StoryDataModel(img_path: value["imgPath"], title: value["title"], description: value["description"]));
    });
    handler(stories);
  }

  void getStories(Function handler) {
    this.apiClient
        .getStories(header: Map<String, String>(), onSuccess: null, onError: null)
        .then((json) => (json != null) ? this._updateStories(json as Map<String, dynamic>, handler) : print('network error'));
  }
}
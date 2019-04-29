import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class StoryDataModel {
  final String imgPath;
  final String title;
  final String description;
  StoryDataModel({@required String img_path, @required String title, @required String description}) :
    imgPath = img_path,
    title = title,
    description = description;
}

class HomePageModel extends AModel {
  HomePageModel(): super();
  List<StoryDataModel> getStories() {
    List<StoryDataModel> result = [];

    return (result);
  }
}
import 'package:partnership/model/ProjectModel.dart';
import 'package:partnership/model/HomePageModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:flutter/material.dart';

class StoryData {
  final String imgPath;
  final String title;
  final String description;
  StoryData(
      {@required String img_path,
      @required String title,
      @required String description})
      : imgPath = img_path,
        title = title,
        description = description;
}

class HomePageViewModel extends AViewModel {
  HomePageViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
  ProjectModel _projectModel;
  HomePageModel _homePageModel = HomePageModel();
  void disconnect(BuildContext context) {
    this.changeView(
        widgetContext: context, route: "/" , popStack: true);
  }

  void goToProfile(BuildContext context) {
    this.changeView(widgetContext: context, route: "/profile_page");
  }

  void getStoryList(Function updateList) async {
    List<StoryDataModel> list = await _homePageModel.getStories();
    List<StoryData> result = list.map((value) { 
      return (StoryData(
          description: value.description,
          title: value.title,
          img_path: value.img_path));
    }).toList();
    updateList(result);
  }
}

import 'package:partnership/model/HomePageModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/ui/widgets/StoryList.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends AViewModel {
  HomePageModel _homePageModel;

  HomePageViewModel(String route) {
    super.initModel(route);
    _homePageModel = super.abstractModel;
  }

  void disconnect(BuildContext context) {
    this.changeView(
        widgetContext: context, route: "/" , popStack: true);
  }
  void goToBrowsingProjectPage(BuildContext context) {
    this.changeView(widgetContext: context, route: "/project_browsing_page");
  }
  void goToCreateProjectPage(BuildContext context) {
    print("=============\n=\n=\n=\n");
    this.changeView(widgetContext: context, route: "/creation_page");
  }
  void goToProfile(BuildContext context) {
    this.changeView(widgetContext: context, route: "/profile_page");
  }

  void getStoryList(Function updateList) {
    _homePageModel.getStories(updateList);
  }

  List<StoryListItem> convertStoryModelToItems(List<StoryDataModel> stories){
      List<StoryListItem> items = stories.map((elem) {
        return (StoryListItem(imgPath: elem.img_path, title:elem.title, description: elem.description));
      }).toList();
      return items;
  }
}

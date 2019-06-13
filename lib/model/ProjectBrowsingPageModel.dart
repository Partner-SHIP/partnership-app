import 'package:flutter/material.dart';
import 'package:partnership/model/AModel.dart';

/*
class ProjectDescriptionItemData {
  final String bannerPath;
  final String logoPath;
  final String description;
  final String name;
  ProjectDescriptionItemData(
      {@required String bannerPath,
      @required String logoPath,
      @required String description,
      @required String name})
      : bannerPath = bannerPath,
        logoPath = logoPath,
        description = description,
        name = name;
}

  ProjectDescriptionItemData _createProjectDescriptionItemData(Map data) {
    if (!data.containsKey("name") ||
        !data.containsKey("bannerPath") ||
        !data.containsKey("description") ||
        !data.containsKey("logoPath"))
        return (null);
    final String title = data["name"];
    final String bannerPath = data["bannerPath"];
    final String description = data["description"];
    final String logoPath = data["logoPath"];
    print("create");
    if (title == null ||
        title.isEmpty ||
        bannerPath == null ||
        bannerPath.isEmpty ||
        logoPath == null ||
        logoPath.isEmpty ||
        description == null ||
        description.isEmpty) return (null);
    print("one okay");
    return (ProjectDescriptionItemData(
        name: title,
        bannerPath: bannerPath,
        logoPath: logoPath,
        description: description));
  }
}
*/

class ProjectBrowsingPageModel extends AModel {
  ProjectBrowsingPageModel() : super();
}

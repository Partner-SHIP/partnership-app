import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ProjectBrowsingPageModel.dart';
import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/ProjectScrollList.dart';


class ProjectBrowsingPageViewModel extends AViewModel {
  ProjectBrowsingPageModel                  _model;
  ProjectBrowsingPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  List<ProjectScrollListItemData> getProjectList() {
    List<ProjectScrollListItemData> result = [
      ProjectScrollListItemData(name:"Projet1", logo: AssetImage("assets/test.png"), banner: AssetImage("assets/bubble_texture.jpg")),
      ProjectScrollListItemData(name:"Projet2", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/blue_texture.jpg")),
      ProjectScrollListItemData(name:"Projet3", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/work-office.png")),
      ProjectScrollListItemData(name:"Projet4", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/test.png")),
      ProjectScrollListItemData(name:"Projet5", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/img/logo_partnership.png")),
      ProjectScrollListItemData(name:"Projet6", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/blue_texture.jpg")),
      ProjectScrollListItemData(name:"Projet8", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/work-office.png")),
      ProjectScrollListItemData(name:"Projet9", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/test.png")),
      ProjectScrollListItemData(name:"Projet10", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/img/logo_partnership.png")),
      ProjectScrollListItemData(name:"Projet11", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/blue_texture.jpg")),
      ProjectScrollListItemData(name:"Projet12", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/work-office.png")),
      ProjectScrollListItemData(name:"Projet13", logo: AssetImage("assets/img/logo_partnership.png"), banner:AssetImage("assets/test.png")),
      ProjectScrollListItemData(name:"Projet14", logo: AssetImage("assets/test.png"), banner:AssetImage("assets/img/logo_partnership.png"))
    ];
    return (result);
  }
  Future<dynamic>  searchTag(String value) async {
    List<dynamic> result = List<dynamic>();
    return (result);
  }
  ProjectBrowsingPageModel get model => this._model;
}
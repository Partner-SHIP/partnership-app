import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ProjectBrowsingPageViewModel.dart';
import 'package:partnership/ui/widgets/ProjectScrollList.dart';
import 'package:partnership/ui/widgets/SearchBar.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';

class ProjectBrowsingPage extends StatefulWidget {
  @override
  ProjectBrowsingPageState createState() => ProjectBrowsingPageState();
}


class ProjectBrowsingPageState extends State<ProjectBrowsingPage> {
  IRoutes      _routing = Routes();
  List<ProjectScrollListItemData> _projectList = List();
  ProjectBrowsingPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.projectBrowsingPage];
  @override
  void initState(){
    super.initState();
    this.viewModel.getProjectList(query:"", onUpdate:(value) => this._updateProjectList(value));
  }
  void _updateProjectList(List<ProjectScrollListItemData> list) {
    this.setState(()
    {
      if (!mounted)
        return ;
      this._projectList = list;
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double listHeight = screenHeight * 9 / 10;
    double searchBarHeight = screenHeight * 1 / 10;

    SearchBar searchBar = SearchBar(onQuery: this.viewModel.searchTag,);
   ProjectScrollList list = ProjectScrollList.fromDataList(this._projectList, height: listHeight);



 return Scaffold(
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel),
      ),
      body: Builder(builder: (BuildContext context){
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              Column(
                children: <Widget>[
                  pageHeader(context, 'Recherche de projets'),
                  searchBar,
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.blue, child: Text('liste de projet'),
                      list,
                    )
                  )
                ],
              )
          ),
        );
      }),
    );
  }
}

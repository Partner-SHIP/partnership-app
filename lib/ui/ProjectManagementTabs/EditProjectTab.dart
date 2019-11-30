import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditProjectTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final Project                        project;
  EditProjectTab(ProjectManagementTabsViewModel vm, Project project) : viewModel = vm, project = project;


  Widget _buildEditBannerWidget(context){
    var screenSize = MediaQuery.of(context).size;
    Container banner;
    return Stack(
      children: <Widget>[
        banner = Container(
          margin: EdgeInsets.all(30),
          width: screenSize.width,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(image: NetworkImage(project.imgUrl), fit: BoxFit.cover)
          ),
        ),
        Positioned(left: 0, right: 0, top: 0, bottom: 0, child: Center(
            child: FloatingActionButton(
                  onPressed: null,
                  child: Icon(Icons.photo_camera, size: 35),
                  )
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        AutoSizeText("Editer la page projet", style: TextStyle(
            fontSize: 20,
            fontFamily: 'Orkney',
            fontWeight: FontWeight.bold,
            color: Colors.white)
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: AutoSizeText("Modifier la bannière", style: TextStyle(
              fontSize: 15,
              fontFamily: 'Orkney',
              fontWeight: FontWeight.bold,
              color: Colors.white)
          ),
        ),
        _buildEditBannerWidget(context)
      ],
    );
  }
}
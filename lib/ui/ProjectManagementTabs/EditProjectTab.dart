import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditProjectTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final Project                        project;
  static final GlobalKey               editNameKey = GlobalKey();
  static final GlobalKey               editDescriptionKey = GlobalKey();
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
                  backgroundColor: AThemes.selectedTheme.bgGradient.colors[0],
                  onPressed: null,
                  child: Icon(Icons.photo_camera, size: 35),
                  )
            )
        ),
      ],
    );
  }

  Widget _buildEditLogoWidget(BuildContext context){
    var screenSize = MediaQuery.of(context).size;
    Container banner;
    return Stack(
      children: <Widget>[
        banner = Container(
          margin: EdgeInsets.all(30),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(image: NetworkImage(project.imgUrl), fit: BoxFit.cover)
          ),
        ),
        Positioned(left: 80, right: 0, top: 80, bottom: 0, child: Center(
            child: FloatingActionButton(
              backgroundColor: AThemes.selectedTheme.bgGradient.colors[0],
              heroTag: "changeLogo",
              onPressed: null,
              child: Icon(Icons.photo_camera, size: 35),
            )
        )
        ),
      ],
    );
  }

  Widget _buildEditNameWidget(BuildContext context){
    TextFormField input = TextFormField(
      key: editNameKey,
      decoration: InputDecoration(
          hintText: 'Modifier le nom',
          labelText: project.projectName,
          labelStyle: TextStyle(fontFamily: "Orkney"),
          hintStyle: TextStyle(fontFamily: "Orkney"),
          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white70)
          ),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
          ),
      )
    );
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 30, left: 10.0, bottom: 5.0, right: 10.0), child: input),
        ),
      ],
    );
  }

  Widget _buildEditDescriptionWidget(BuildContext context){
    TextFormField input = TextFormField(
        key: editDescriptionKey,
        decoration: InputDecoration(
          hintText: 'Modifier la description',
          labelText: project.imgUrl,
          labelStyle: TextStyle(fontFamily: "Orkney"),
          hintStyle: TextStyle(fontFamily: "Orkney"),
          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white70)
          ),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
          ),
        )
    );
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 30, left: 10.0, bottom: 5.0, right: 10.0), child: input),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      splashColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
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
            _buildEditBannerWidget(context),
            Container(
              //margin: EdgeInsets.only(top: 30),
              child: AutoSizeText("Modifier le logo", style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Orkney',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
              ),
            ),
            _buildEditLogoWidget(context),
            Container(
              //margin: EdgeInsets.only(top: 30),
              child: AutoSizeText("Modifier le nom", style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Orkney',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
              ),
            ),
            _buildEditNameWidget(context),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: AutoSizeText("Modifier la description", style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Orkney',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
              ),
            ),
            _buildEditDescriptionWidget(context)
          ],
        ),
      ),
    );
  }
}
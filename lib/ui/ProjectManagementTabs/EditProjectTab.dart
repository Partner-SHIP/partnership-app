import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditProjectTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final DocumentSnapshot               project;
  String                               name;
  String                               description;
  static final GlobalKey<FormState>               editNameKey = GlobalKey<FormState>();
  static final GlobalKey<FormState>               editDescriptionKey = GlobalKey<FormState>();
  EditProjectTab(ProjectManagementTabsViewModel vm, DocumentSnapshot project) : viewModel = vm, project = project;

  String _validateName(String value){
    if (value.isEmpty)
      return "vous devez entrer un nom";
    return null;
  }

  String _validateDescription(String value){
    if (value.isEmpty)
      return "vous devez entrer une decription";
    return null;
  }

  void _saveName(String value){
    this.name = value;
  }

  void _saveDescription(String value){
    this.description = value;
  }

  void _editName(){
    if (editNameKey.currentState.validate()){
      editNameKey.currentState.save();
    }
  }

  void _editDescription(){
    if (editDescriptionKey.currentState.validate()){
      editDescriptionKey.currentState.save();
    }
  }

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
              image: DecorationImage(image: NetworkImage(project["bannerPath"]), fit: BoxFit.cover)
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
              image: DecorationImage(image: NetworkImage(project["logoPath"]), fit: BoxFit.cover)
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
        validator: _validateName,
        onSaved: _saveName,
        decoration: InputDecoration(
          hintText: 'Modifier le nom',
          labelText: project["name"],
          labelStyle: TextStyle(fontFamily: "Orkney"),
          hintStyle: TextStyle(fontFamily: "Orkney"),
          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: AThemes.selectedTheme.bgGradient.colors[0])
          ),
        icon: Icon(Icons.edit, color: AThemes.selectedTheme.bgGradient.colors[0]),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
          ),
      )
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0), child: input),
        ),
        Padding(
          child: RaisedButton(
            child: AutoSizeText(
                "éditer",
                style: TextStyle(fontSize: 15, fontFamily: 'Orkney', fontWeight: FontWeight.bold, color: Colors.white)
            ),
            color: AThemes.selectedTheme.bgGradient.colors[0], onPressed: _editName,
          ),
          padding: EdgeInsets.only(right: 10, bottom: 10),
        )
      ],
    );
  }

  Widget _buildEditDescriptionWidget(BuildContext context){
    TextFormField input = TextFormField(
        key: editDescriptionKey,
        validator: _validateDescription,
        onSaved: _saveDescription,
        decoration: InputDecoration(
          hintText: 'Modifier la description',
          labelText: project["description"],
          labelStyle: TextStyle(fontFamily: "Orkney"),
          hintStyle: TextStyle(fontFamily: "Orkney"),
          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: AThemes.selectedTheme.bgGradient.colors[0])
          ),
          icon: Icon(Icons.edit, color: AThemes.selectedTheme.bgGradient.colors[0]),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
          ),
        )
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only( left: 10.0, bottom: 5.0, right: 10.0), child: input),
        ),
        Padding(
          child: RaisedButton(
              child: AutoSizeText(
                  "éditer",
                  style: TextStyle(fontSize: 15, fontFamily: 'Orkney', fontWeight: FontWeight.bold, color: Colors.white)
              ),
              color: AThemes.selectedTheme.bgGradient.colors[0], onPressed: _editDescription,
          ),
          padding: EdgeInsets.only(right: 10, bottom: 10),
        )
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
              margin: EdgeInsets.only(bottom: 30),
              child: AutoSizeText("Modifier le nom", style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Orkney',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
              ),
            ),
            _buildEditNameWidget(context),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
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
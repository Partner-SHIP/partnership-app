import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/CreationPageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

class CreationPage extends StatefulWidget {
  @override
  CreationPageState createState() => CreationPageState();
}

class CreationPageState extends State<CreationPage> {
  IRoutes _routing = Routes();

  CreationPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.creationPage];

  File _image;
  File _logo;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

    Future _getLogo() async {
    var logo = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _logo = logo;
    });
  }

  bool _validateName = false;
  bool _validateDesc = false;
  final _nameProject = TextEditingController();
  final _descriptionProject = TextEditingController();
  Form _form;
  NetworkImage get image => viewModel.image;
  BuildContext _scaffoldContext;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameProject.dispose();
    _descriptionProject.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _form = _buildForm();
  }

  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Builder(
            builder: (BuildContext context) {
              viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.creationPage));
              return InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SafeArea(
                    top: false,
                    child: ThemeContainer(
                        context,
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //_creationProjectHeaderWidget(),
                              pageHeader(context, 'Création de projet'),
                              SizedBox(width: 0, height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: (MediaQuery.of(context).size.width / 100)),
                                child: _creationProjectRowImageWidget(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: (MediaQuery.of(context).size.width / 10),
                                    left: (MediaQuery.of(context).size.width / 100)),
                                child: _creationProjectRowLogoWidget(),
                              ),
                              _form,
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: (MediaQuery.of(context).size.width / 2.5),
                                      bottom: 35
                                  ),
                                  child: _validatingProject()),
                            ],
                          ),
                        )
                    )
                ),
              );
            }
        ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel, projectCreation: false),
      ),
    );
  }

  Form _buildForm() {
    Form result = Form(
      child: Column(
        children: <Widget>[
          SizedBox(width: 0, height: 5),
          _creationProjectNameWidget(),
          _creationProjectDescWidget(),
          SizedBox(width: 0, height: 5),
        ],
      ),
    );
    return (result);
  }

  Widget _creationProjectHeaderWidget() {
    return Row(
      children: <Widget>[
        Padding(
          child: Image.asset('assets/img/partnership_logo.png',
              width: 100, height: 100),
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40, left: 13),
          child: Text(
            'Création de projet',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'Orkney'),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 40, top: 20),
            child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openEndDrawer())),
      ],
    );
  }

  Widget _creationProjectRowImageWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _creationProjectImageWidget(),
              Positioned (
                bottom: 0,
                right: 10,
                child: this._changePhotoButton())
            ],
          ),
        ),
      ],
    );
  }

  Widget _creationProjectImageWidget() {
    if (_image == null) {
      return Container(
        width: (MediaQuery.of(context).size.width / 1.1),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: image, fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
      );
    } else {
      return Container(
        width: (MediaQuery.of(context).size.width / 1.1),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: FileImage(_image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
      );
    }
  }

  Widget _creationProjectRowLogoWidget() {
  return Row(
    children: <Widget>[
      Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _creationProjectLogoWidget(),
            Positioned (
              bottom: 0,
              right: 100,
              child: this._changeLogo())
          ],
        ),
      ),
    ],
  );
}

  Widget _creationProjectLogoWidget() {
  if (_logo == null) {
    return Container(
      width: (MediaQuery.of(context).size.width / 3.5),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: image, fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
  );
} else {
return Container(
        width: (MediaQuery.of(context).size.width / 3.5),
        height: 100,
        decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: FileImage(_logo), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
    );
  }
}

  Widget _creationProjectDescWidget() {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: new Theme(
        data: new ThemeData(
          hintColor: Colors.white70
        ),
      child: new Center(
          child: new Column(children: [
        //new Padding(padding: EdgeInsets.only(top: 1.0)),
        new Text(
          'Description',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontFamily: "Orkney",
          ),
        ),
        new Padding(padding: EdgeInsets.only(top: 15.0)),
        new TextFormField(
          maxLength: 150,
          controller: _descriptionProject,
          validator: (_validateDesc) {
            if (_validateDesc.isEmpty) {
              return "Veuillez entrer une description";
            }
          },
          decoration: new InputDecoration(
            errorText: _validateDesc ? "Ce champ ne peut être vide" : null,
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Entrer une description",
            fillColor: Colors.white,
            enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white70)
              ),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
              )
            ),
          maxLines: 5,
          keyboardType: TextInputType.text,
          style: new TextStyle(
            fontFamily: "Orkney",
            color: Colors.white,
          ),
        ),
      ])),
    )
    );
  }

  Widget _creationProjectNameWidget() {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: new Theme(
        data: new ThemeData(
          hintColor: Colors.white70
        ),
      child: new Center(
          child: new Column(children: [
        //new Padding(padding: EdgeInsets.only(top: 10.0)),
        new Text(
          'Nom du projet',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontFamily: "Orkney",
          ),
        ),
        new Padding(padding: EdgeInsets.only(top: 15.0)),
        new TextFormField(
          maxLines: 1,
          maxLength: 30,
          controller: _nameProject,
          validator: (_validateDesc) {
            if (_validateDesc.isEmpty) {
              return "Veuillez entrer une description";
            }
          },
          decoration: new InputDecoration(
            errorText: _validateDesc ? "Ce champ ne peut être vide" : null,
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Entrer un nom de projet",
            fillColor: Colors.white,
            enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white70)
            ),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
            )
          ),
          keyboardType: TextInputType.text,
          style: new TextStyle(
            fontFamily: "Orkney",
            color: Colors.white,
          ),
        ),
      ])),
    )
    );
  }

  Widget _changePhotoButton() {
    return FloatingActionButton(
        heroTag: "changePhoto",
        onPressed: _getImage,
        child: Icon(Icons.photo_camera, size: 35));
  }

  Widget _changeLogo() {
    return FloatingActionButton(
        heroTag: "changeLogo",
        onPressed: _getLogo,
        child: Icon(Icons.photo_camera, size: 35));
  }

  Widget _validatingProject() {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Material(
              type: MaterialType.transparency,
              child: Center(
                  child: FlareActor('assets/animations/Liquid Loader.flr', animation: 'Untitled')
              ),
            );
          },
        );
        this.viewModel.postProject(context, _nameProject, _descriptionProject, _image, (String value){
          print("COUCOU" + value);
          Navigator.of(context).pop();
          viewModel.changeView(route: _routing.homePage, widgetContext: context);
        });
        },
      heroTag: "postProject",
      label: Text("Créer"),
      tooltip: "Créer le projet",
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }
}
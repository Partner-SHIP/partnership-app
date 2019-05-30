import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/CreationPageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';


class CreationPage extends StatefulWidget {
    @override
    CreationPageState createState() => CreationPageState();
}

class CreationPageState extends State<CreationPage> {
  IRoutes _routing = Routes();

  CreationPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.creationPage];



  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

  bool _validateName = false;
  bool _validateDesc = false;
  final _nameProject = TextEditingController(text: "Nom du projet");
  NetworkImage get image => viewModel.image;
  final _descriptionProject = TextEditingController();
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
  void initState(){
    super.initState();
  }

 Widget build(BuildContext context) {
   _scaffoldContext = context;

          return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            top: false,
            child: ThemeContainer(context, Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              _creationProjectHeaderWidget(),
              SizedBox(width: 0, height: 10),
              Padding(
                padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 100)),
                child: _creationProjectRowImageWidget(),
                ),
              SizedBox(width: 0, height: 5),
              _creationProjectNameWidget(),
              _creationProjectDescWidget(),
              SizedBox(width: 0, height: 5),
              Padding(
                padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2.3)), 
              child: _validatingProject()
              ),
              ],
            )
          )
        )
    );
 }

Widget _creationProjectHeaderWidget()
{
   return Row(
        children: <Widget>[
        Padding(
          child: Image.asset('assets/img/partnership_logo.png', width:100, height: 100),
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
          ),
        Padding(
          padding: EdgeInsets.only(top: 40, left: 13),
          child: Text(
          'Création de projet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Orkney'
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 20),
        child: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openEndDrawer())
        ),
      ],
      );
}
Widget _creationProjectRowImageWidget(){
     return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _creationProjectImageWidget(),
              this._changePhotoButton()
            ],
          ),
        ),
      ],
    );
}
Widget _creationProjectImageWidget() {
    if (_image == null) {
      return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 7.0,
                    color: Colors.black
                )
              ]
          ),
      );
    }
    else {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: FileImage(_image),
            ),
            borderRadius: BorderRadius.all(Radius.circular(75.0)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7.0,
                  color: Colors.black
              )
            ]
        ),
      );
    }
  }

Widget _creationProjectDescWidget(){
    return Container (
      padding: const EdgeInsets.all(1.0),
      child: new Container(
        child: new Center(
          child: new Column(
            children : [
              new Padding(padding: EdgeInsets.only(top: 1.0)),
              new Text('Description',
                style: new TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "Orkney",),),
                new Padding(padding: EdgeInsets.only(top: 1.0)),
                new TextFormField(
                  decoration: new InputDecoration(
                  labelText: "Entrer une description",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                    ),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Orkney",
                    color: Colors.white,
                    ),
                ),
            ]
          )
        ),
      ),
    );
  }

 Widget _creationProjectNameWidget(){
    return Container (
      padding: const EdgeInsets.all(30.0),
      child: new Container(
        child: new Center(
          child: new Column(
            children : [
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new Text('Nom du projet',
                style: new TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "Orkney",),),
                new Padding(padding: EdgeInsets.only(top: 1.0)),
                new TextFormField(
                  decoration: new InputDecoration(
                  labelText: "Entrer un nom de projet",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                    ),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Orkney",
                    color: Colors.white,
                    ),
                ),
            ]
          )
        ),
      ),
    );
  }
    Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35)
        );
  }
  Widget _validatingProject(){
   return FloatingActionButton(
    onPressed: () => this.setState((){}),
    child: Icon(Icons.add, size: 35),
    tooltip: "Créer le projet",
    backgroundColor: Colors.grey,
    foregroundColor: Colors.white,
    );
  }
}
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
                padding: EdgeInsets.only(left:130),
                child: _creationProjectImageWidget(),
                ),
              SizedBox(width: 0, height: 10),
              _creationProjectNameWidget(),
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
                new Padding(padding: EdgeInsets.only(top: 50.0)),
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
  Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
}
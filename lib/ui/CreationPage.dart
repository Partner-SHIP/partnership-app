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
            _TopSide(),
            _creationProjectImageWidget(),
              ],
            )
          )
        )
    );
 }

Widget _TopSide()
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
}
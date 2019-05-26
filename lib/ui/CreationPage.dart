import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/CreationPageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
            child: ThemeContainer(context, Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Padding(
                    child: Image.asset('assets/img/partnership_logo.png', width:110, height: 110),
                    padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80, left: 15),
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
            ))
        )
    );
 }
}
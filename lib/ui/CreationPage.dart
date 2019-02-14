import 'dart:io';
import 'package:flutter/material.dart';
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Création de projet'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          new FloatingActionButton(
            onPressed: getImage,
            child: _image == null
                ? Icon(Icons.add_a_photo)
                : new CircleAvatar(radius: 20.0, child: Image.file(_image)),
            tooltip: 'Pick Image',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          new ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Nom du projet",
                labelStyle: new TextStyle(fontSize: 24.0),
              ),
              style: new TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Description',
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 24.0, color: Colors.black45),
              ),
            ),
          new ListTile(
            title: new TextFormField(
              decoration: new InputDecoration(
                labelStyle: new TextStyle(fontSize: 20.0),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              style: new TextStyle(fontSize: 24.0, color: Colors.black),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}


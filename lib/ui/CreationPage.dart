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
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Création de projet'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Chargement en cours')));
        }
      },
          child: Icon(Icons.check), tooltip: 'Confimez vous les informations'),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          new RaisedButton(onPressed: getImage, color: Colors.blue, child: _image == null ? null : Image.file(_image)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            child: Text(
              'Nom du projet',
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
          new ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: 'Exemple : PartnerSHIP...',
                labelStyle: new TextStyle(fontSize: 24.0),
              ),
              style: new TextStyle(fontSize: 24.0, color: Colors.black),
              validator: (value) {
                if (value.isEmpty)
                  return 'Ce champ ne peut être vide';
              },
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
              style: TextStyle(fontSize: 24.0, color: Colors.black),
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


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

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

  final myControllerOne = TextEditingController();
  final myControllerTwo = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myControllerOne.dispose();
    myControllerTwo.dispose();
    super.dispose();
  }

  bool isEditing = false;
  String get name => viewModel.name;
  String get location => viewModel.location;
  NetworkImage get image => viewModel.image;
  AssetImage get background => viewModel.background;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ProfileInheritedWidget(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.blue[600],
            child: Container(height: 50),
          ),
          floatingActionButton: _editingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _profileHeaderWidget(),
                    SizedBox(width: 0.0, height: 10.0),
                    _profileContentWidget()
                  ],
                ),
              )
          )
      ),
      state: this,
    );
  }

  Widget _editingButton(){
    var ret;
    if (this.isEditing){
      ret = FloatingActionButton(
        onPressed: () => this.setState((){
          this.isEditing = !this.isEditing;
        }),
        child: Icon(Icons.check, size: 35),
        tooltip: "Sauvegarder",
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      );
    }
    else {
      ret = FloatingActionButton(
        onPressed: () => this.setState((){
          this.isEditing = !this.isEditing;
        }),
        child: Icon(Icons.edit, size: 35),
        tooltip: "Editer",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      );
    }
    return ret;
  }

  Widget _profileHeaderWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _clipPathWidget(),
              _profileImageWidget(),
              this.isEditing ? this._changePhotoButton() : SizedBox(width: 0,height: 0)
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileContentWidget(){
    return Container(
        decoration: BoxDecoration(
            color: Colors.green,
            gradient: LinearGradient(
                colors: [Colors.cyan[700], Colors.cyan[400], Colors.cyan[700]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,//Alignment(0.8, 0.0),
                tileMode: TileMode.clamp
            )
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(width: 0, height: 10),
              _profileNameWidget(),
              SizedBox(width: 0, height: 10),
              _descriptionAtWidget(),
            ],
          ),
        )
    );
  }

  Widget _descriptionAtWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            )
        ),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Description :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenterTwo("Qui êtes-vous, que proposez-vous ...", "Changer votre description ici") :
            Text(
                myControllerTwo.text,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)
            ),
          ],
        )
    );
  }

  Widget _clipPathWidget(){
    return ClipPath(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/blue_texture.jpg'),
                fit: BoxFit.cover
            )
        ),
      ),
      clipper: ProfileClipper(),
    );
  }

  Widget _profileImageWidget() {
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
  }

  Widget _editablePresenterOne(String label, String hint){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                controller: myControllerOne,
                decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                maxLines: null,
              )
          ),
        ),
      ],
    );
  }

  Widget _editablePresenterTwo(String label, String hint){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                controller: myControllerTwo,
                decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                maxLines: null,
              )
          ),
        ),
      ],
    );
  }

  Widget _profileNameWidget(){
    var ret;
    if (this.isEditing) {
      ret = this._editablePresenterOne("Nom du projet", "Changer le nom du projet");
    }
    else {
      ret = Text(
        myControllerOne.text,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.white),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: ret,
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2.5,
                  color: Colors.white
              )
          )
      ),
    );
  }

  Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35),
    );
  }
}

class ProfileInheritedWidget extends InheritedWidget {
  final CreationPageState state;
  ProfileInheritedWidget(
      {
        this.state,
        Widget child
      }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 20.0);
    path.lineTo(10.0, size.height - 10.0);
    path.lineTo(size.width / 4, size.height - 10.0);
    path.lineTo(size.width / 3, size.height);
    path.lineTo(size.width - (size.width / 3), size.height);
    path.lineTo(size.width - (size.width / 4), size.height - 10.0);
    path.lineTo(size.width - 10.0, size.height - 10.0);
    path.lineTo(size.width, size.height - 20.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}


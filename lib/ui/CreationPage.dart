import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partnership/style/theme.dart';
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


    final titleWidget = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff20264c).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff20264c).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            ),
            Text('PartnerShip',
                style: TextStyle(
                  //color: Colors.white,
                  fontFamily: 'Copperplate',
                  fontSize: 35,
                  foreground: Paint()
                    ..shader = Gradients.verticalMetallic.createShader(Rect.fromLTWH(0, 150, 250, 40))
              )
            ),
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff35294f).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff35294f).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            )
          ],
        )
      );
          return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            top: false,
            child: ThemeContainer(context, Column(
              children: <Widget>[
                Padding(
                  child: Image.asset('assets/img/logo_partnership.png', width:50, height: 50),
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                ),
                titleWidget,
              ],
            ))
        )
    );
 }
}
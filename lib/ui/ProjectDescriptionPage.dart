import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ProjectDescriptionPageViewModel.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

final String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class ProjectDescriptionPage extends StatefulWidget {
  static _ProjectDescriptionPageState _state;
  ProjectDescriptionPage(Map<String, dynamic> args) {
    _state = _ProjectDescriptionPageState(args);
  }

  @override
  _ProjectDescriptionPageState createState() => _state;
}

class _ProjectDescriptionPageState extends State<ProjectDescriptionPage> {
  bool busy = false;
  IRoutes _routing = Routes();
  StreamSubscription _connectivitySub;
  ProjectDescriptionPageViewModel viewModel;
  Map<String, dynamic> args;

  _ProjectDescriptionPageState(Map<String, dynamic> parameters) : args = parameters;

  @override
  void initState(){
    super.initState();
    DocumentSnapshot project = args['project'];
    var data = project.data;
    print('ARGUMENT : $data');
    viewModel = AViewModelFactory.createDynamicViewModel(route: _routing.projectDescriptionPage);
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  Image _buildBanner(BuildContext context) {
    return Image.network(
      args['project'].data['bannerPath'],
      width: MediaQuery.of(context).size.width,
      height: 250,
      fit: BoxFit.cover,
    );
  }
  Container _buildTitle () {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AutoSizeText(
                    args['project'].data['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orkney',
                      fontSize: 20
                    ),
                  ),
                ),
                AutoSizeText(
                  args['project'].data['description'],
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'Orkney'
                  ),
                ),
              ],
            ),
          ),
          /*
          Icon(
            Icons.loyalty,
            color: Colors.red[500],
          ),
          AutoSizeText('410', style: TextStyle(color: Colors.white, fontFamily: 'Orkney')),
          */
        ],
      ),
    );
  }
  Row _buildDescription (BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double paddingvalue = 5;
    Text text =Text(lorem);
    Padding padding =Padding(child: Container(child:text, width: width - paddingvalue * 2,), padding: EdgeInsets.all(paddingvalue),);
    Row result = Row(children: <Widget>[Column(children: <Widget>[padding],mainAxisSize: MainAxisSize.max,)], mainAxisSize: MainAxisSize.max,);
    return (result);
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Orkney',
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Container buttonSection = Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.white, Icons.loyalty, 'SUIVRE'),
          _buildButtonColumn(Colors.white, Icons.people, 'REJOINDRE'),
          _buildButtonColumn(Colors.white, Icons.share, 'PARTAGER'),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ThemeContainer(
          context,
          ListView(
            children: <Widget>[
              _buildBanner(context),
              _buildTitle(),
              buttonSection,
              _buildDescription(context)
            ],
          )
        ),
      ),
    );
  }

  void _connectivityHandler(bool value) {

  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/IdeaPageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

class IdeaPage extends StatefulWidget {
  @override
  IdeaPageState createState() => IdeaPageState();
}

class IdeaPageState extends State<IdeaPage> {
  IRoutes _routing = Routes();

 IdeaPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.creationPage];

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  }

}
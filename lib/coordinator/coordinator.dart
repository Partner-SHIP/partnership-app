import 'package:flutter/material.dart';
import 'routing_module.dart';
import 'connectivity_module.dart';

/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/
class Coordinator extends State<PartnershipApp>{

  static final RoutingModule router = RoutingModule();
  static final ConnectivityModule connectivity = ConnectivityModule();
  Coordinator(){
    connectivity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PartnerSHIP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Coordinator.router.generator(),
      initialRoute: Handlers.routes[1],
    );
  }
}

// Main entry of the Application
class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}
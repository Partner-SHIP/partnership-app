import 'package:flutter/material.dart';
import 'routing_module.dart';

class Coordinator extends State<PartnershipApp>{

  static final RoutingModule router = RoutingModule();

  Coordinator();

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

class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}
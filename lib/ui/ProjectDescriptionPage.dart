import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ProjectDescriptionPageViewModel.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/style/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import 'dart:async';

//final String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

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
  _ProjectDescriptionPageState(Map<String, dynamic> parameters)
      : args = parameters;

  @override
  void initState() {
    super.initState();
    DocumentSnapshot project = args['project'];
    var data = project.data;
    print('ARGUMENT : $data');
    viewModel = AViewModelFactory.createDynamicViewModel(
        route: _routing.projectDescriptionPage);
    this._connectivitySub =
        viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose() {
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

  Widget _buildLogo() {
    return ClipPath(
      child: Container(
          margin: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(gradient: AThemes.selectedTheme.bgGradient),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //AutoSizeText("LOGO PLACEHOLDER"),
              Image.network(args['project'].data['logoPath'],
                  fit: BoxFit.fitHeight),
            ],
          )),
      clipper: LogoClipper(),
    );
  }

  Container _buildTitle() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AutoSizeText(
                    args['project'].data['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orkney',
                        fontSize: 20),
                  ),
                ),
                AutoSizeText(
                  args['project'].data['description'],
                  style: TextStyle(color: Colors.white, fontFamily: 'Orkney'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildDescription(BuildContext context) {
    //AutoSizeText text = AutoSizeText(lorem, style: TextStyle(color: Colors.white, fontSize: 18), softWrap: true,);
    Row result = Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(24),
        )
      ],
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
    );
    return (result);
  }

  Widget _buildButtonColumn(
      Color color, IconData icon, String label, BuildContext context) {
    return InkWell(
        onTap: () {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("BUTTON PUSHED")));
          this.viewModel.addLike(args['project'].data['pid'], (String value) {
            print("COUCOU" + value);
            Navigator.of(context).pop();
            viewModel.changeView(
                route: _routing.homePage, widgetContext: context);
          });
        },
        child: ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return AThemes.selectedTheme.btnGradient.createShader(bounds);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 50),
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
          ),
        ));
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.white, Icons.loyalty, 'AIMER', context),
          _buildButtonColumn(Colors.white, Icons.people, 'SUIVRE', context),
          _buildButtonColumn(Colors.white, Icons.share, 'REJOINDRE', context),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context){
        viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.projectDescriptionPage));
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              ListView(
                children: <Widget>[
                  _buildBanner(context),
                  _buildLogo(),
                  _buildTitle(),
                  _buildButtons(context),
                  _buildDescription(context)
                ],
              )),
        );
      }),
    );
  }

  void _connectivityHandler(bool value) {}
}

class LogoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    /*
    path.lineTo(0.0, size.height / 6.0);
    path.lineTo(size.width / 2, size.height / 3.0);
    path.lineTo(size.width, size.height / 6.0);
    path.lineTo(size.width, 0.0);
    */
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

import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission/permission.dart';
import 'dart:async';
import 'dart:io';
import 'package:tuple/tuple.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
  static ProfilePageState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProfileInheritedWidget)
            as ProfileInheritedWidget)
        .state;
  }
}

class ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  static final IRoutes _routing = Routes();
  static final ProfilePageViewModel viewModel =
      AViewModelFactory.register[_routing.profilePage];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  StreamSubscription _connectivitySub;
  Map<String, Tuple2<Key, TextEditingController>> _keyMap =
      Map<String, Tuple2<Key, TextEditingController>>();
  List<String> values = List<String>();
  List<MyItems> items = [
    MyItems("Mes Projets", "pas encore disponible"),
    //MyItems("Partners", "body"),
    //MyItems("Other", "body")
  ];
  bool isEditing = false;
  bool isBusy = false;
  File imagePickerFile;
  /////////////////////////////////////GETTERS
  String firstName = viewModel.firstName;
  String lastName = viewModel.lastName;
  String location = viewModel.location;
  int date = viewModel.date;
  String workLocation = viewModel.workLocation;
  String job = viewModel.job;
  String studies = viewModel.studies;
  String photoUrl = viewModel.photoUrl;
  String backgroundUrl = viewModel.backgroundUrl;
  ////////////////////////////////////
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    this._connectivitySub =
        viewModel.subscribeToConnectivity(this._connectivityHandler);
    _tabController = TabController(vsync: this, length: 2);
    viewModel.getCurrentUserProfile(this._updateProfile);
  }

  @override
  void dispose() {
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ProfileInheritedWidget(
    //   child: Scaffold(
    //     key: _mainKey,
    //     bottomNavigationBar: BottomAppBar(
    //       color: Colors.blue[600],
    //       child: Container(height: 50),
    //     ),
    //     floatingActionButton: _editingButton(),
    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //     body: SafeArea(
    //         child: SingleChildScrollView(
    //           child: Form(
    //             key: _formKey,
    //             child: Column(
    //               children: <Widget>[
    //                 _profileHeaderWidget(),
    //                 SizedBox(width: 0.0, height: 10.0),
    //                 _profileContentWidget()
    //               ],
    //             ),
    //           )
    //         )
    //     )
    //   ),
    //   state: this,
    // );
    return Scaffold(
      floatingActionButton: _editingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Builder(builder: (BuildContext context) {
        viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.profilePage));
        return SafeArea(
            top: false,
            child: ThemeContainer(
                context,
                SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          pageHeader(context, 'Profil'),
                          _profilePicture(),
                          Padding(
                              child: _nameWidget(),
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 5, left: 5, right: 5)),
                          Padding(
                              child: _registrationDateWidget(),
                              padding: EdgeInsets.all(5)),
                          _livesAtWidget(),
                          _studiedAtWidget(),
                          _worksAtWidget(),
                          _jobWidget(),
                          _profilePanelList(),
                          SizedBox(height: 80)
                        ],
                      )),
                )));
      }),
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(
            context: context, viewModel: viewModel, profile: false),
      ),
    );
  }

  void _updateProfile(Map<String, dynamic> newProfile){
    print(newProfile);
    this.setState(() {
      print('yessssss');
      print(newProfile);
      print(newProfile['createdAt']['_seconds']);
      this.firstName = newProfile['firstName'] ?? 'Prenom';
      this.lastName = newProfile['lastName'] ?? 'Nom';
      this.date = newProfile['createdAt']['_seconds'] ?? 1552380987;
      this.job = newProfile['job'] ?? 'Occupation';
      this.location = newProfile['cityLocation'] ?? 'ville de résidence';
      this.workLocation = newProfile['workLocation'] ?? 'Employeur';
      this.studies = newProfile['studies'] ?? 'études réalisées';
      //this.photoUrl = newProfile['photoUrl'] ?? 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg' ;
      //this.photoUrl = newProfile['photoUrl'] ?? 'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/Jeff.png?alt=media&token=eca3cf05-67ce-415f-adab-5f989911ef75' ;
      //dans le else, image par défaut si l'utilisateur n'en a pas uploadé une
      this.photoUrl = newProfile['photoUrl'] ??
          'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/unknowprofilepicture.png?alt=media&token=80d8fd66-ab70-4c8a-bd9f-bed1897e3234';
    });
  }

  Widget _profilePicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: imagePickerFile != null
                            ? Image.file(imagePickerFile).image
                            : NetworkImage(this.photoUrl),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 7.0, color: Colors.black)
                    ]),
              ),
            ),
            this.isEditing
                ? _changePhotoButton()
                : SizedBox(width: 0, height: 0),
            this.isBusy ? _spinner() : SizedBox(width: 0, height: 0)
          ],
        )
      ],
    );
  }

  Widget _registrationDateWidget() {
    final myDateFormat = new DateFormat('dd-MM-yyyy');
    String date = myDateFormat
        .format(new DateTime.fromMillisecondsSinceEpoch(this.date * 1000));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText("Inscrit depuis le : ",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        AutoSizeText(date,
            style: TextStyle(
                fontSize: 15, fontFamily: 'Orkney', color: Colors.white))
      ],
    );
  }

  Widget _nameWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(this.firstName + ' ' + this.lastName,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white))
      ],
    );
  }

  Widget _profileTabBarView() {
    return Container(
      height: 80,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: TextField(
                decoration:
                    const InputDecoration(hintText: 'Search for address...'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Latitude: 48.09342\nLongitude: 11.23403'),
              trailing: new IconButton(
                  icon: const Icon(Icons.my_location), onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editingButton() {
    return FloatingActionButton(
      onPressed: () {
        if (this.isEditing) {
          if (this._formKey.currentState.validate()) {
            this._formKey.currentState.save();
            //this.values.forEach((s) => print(s));
            Map<String, String> args = {
              'cityLocation': values[0],
              'studies': values[1],
              'workLocation': values[2],
              'job': values[3],
              'firstName': this.firstName,
              'lastName': this.lastName
            };
            viewModel.postProfile(args, this._updateProfile);
          }
        }
        this.setState(() {
          this.isEditing = !this.isEditing;
        });
      },
      child: this.isEditing
          ? Icon(Icons.check, size: 35)
          : Icon(Icons.edit, size: 35),
      tooltip: this.isEditing ? "valider les changements" : "éditer",
      foregroundColor: Colors.white,
      backgroundColor: this.isEditing ? Colors.green : Colors.blueAccent,
    );
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
              this.isEditing
                  ? this._changePhotoButton()
                  : SizedBox(width: 0, height: 0),
              _spinner()
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileContentWidget() {
    return Container(
        decoration: BoxDecoration(
            //image: DecorationImage(image: NetworkImage(viewModel.backgroundUrl), fit: BoxFit.fill),
            gradient: LinearGradient(
                colors: [Colors.cyan[700], Colors.cyan[400], Colors.cyan[700]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight, //Alignment(0.8, 0.0),
                tileMode: TileMode.clamp)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(width: 0, height: 10),
              _profileNameWidget(),
              SizedBox(width: 0, height: 10),
              _livesAtWidget(),
              _studiedAtWidget(),
              _worksAtWidget(),
              _jobWidget(),
              _profilePanelList()
            ],
          ),
        ));
  }

  Widget _livesAtWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        // decoration: BoxDecoration(
        //     border: Border(
        //         bottom: BorderSide(
        //           width: 1.0,
        //           color: Colors.white,
        //         ),
        //         top: BorderSide(
        //           width: 1.0,
        //           color: Colors.white,
        //         ))),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Habite à :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orkney',
                  color: Colors.white),
            ),
            this.isEditing
                ? this._editablePresenter(
                    this.location, "modifier içi", "location")
                : Text(this.location,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orkney',
                        color: Colors.white)),
          ],
        ));
  }

  Widget _studiedAtWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        // decoration: BoxDecoration(
        //     border: Border(
        //   bottom: BorderSide(
        //     width: 1.0,
        //     color: Colors.white,
        //   ),
        // )),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "A étudié à :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orkney',
                  color: Colors.white),
            ),
            this.isEditing
                ? this
                    ._editablePresenter(this.studies, "modifier içi", "studies")
                : Text(this.studies,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orkney',
                        color: Colors.white)),
          ],
        ));
  }

  Widget _worksAtWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        // decoration: BoxDecoration(
        //     border: Border(
        //   bottom: BorderSide(
        //     width: 1.0,
        //     color: Colors.white,
        //   ),
        // )),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Travaille à :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orkney',
                  color: Colors.white),
            ),
            this.isEditing
                ? this._editablePresenter(
                    this.workLocation, "modifier içi", "workLocation")
                : Text(this.workLocation,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orkney',
                        color: Colors.white)),
          ],
        ));
  }

  Widget _jobWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        // decoration: BoxDecoration(
        //     border: Border(
        //   bottom: BorderSide(
        //     width: 1.0,
        //     color: Colors.white,
        //   ),
        // )),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Travaille en tant que :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orkney',
                  color: Colors.white),
            ),
            this.isEditing
                ? this._editablePresenter(this.job, "modifier içi", "job")
                : Text(this.job,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orkney',
                        color: Colors.white)),
          ],
        ));
  }

  Widget _clipPathWidget() {
    return ClipPath(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(this.backgroundUrl), fit: BoxFit.cover)),
      ),
      clipper: ProfileClipper(),
    );
  }

  Future _getImage() async {
    List<Permissions> permissionNames = await Permission.requestPermissions(
        [PermissionName.Camera, PermissionName.Storage]);
    List<Permissions> permissions = await Permission.getPermissionsStatus(
        [PermissionName.Camera, PermissionName.Storage]);
    if (permissions[0].permissionStatus == PermissionStatus.allow &&
        permissions[1].permissionStatus == PermissionStatus.allow) {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        this.imagePickerFile = image;
      });
    }
  }

  Widget _profileImageWidget() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: imagePickerFile != null
                  ? Image.file(imagePickerFile).image
                  : NetworkImage(this.photoUrl),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
    );
  }

  Widget _editablePresenter(String label, String hint, String keyLabel) {
    Widget ret;
    Key key = Key(keyLabel);
    TextEditingController controller = TextEditingController();
    TextFormField input = TextFormField(
      controller: controller,
      validator: (value) {
        _formValidation(value);
      },
      onSaved: (value) {
        _onSaved(value);
      },
      key: key,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(Icons.edit, color: Colors.white)),
    );
    ret = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0), child: input),
        ),
        FlatButton.icon(
            onPressed: () => controller.clear(),
            icon: Icon(Icons.cancel, color: Colors.red),
            label: Text(
              "effacer",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
    this._keyMap[keyLabel] =
        Tuple2<Key, TextEditingController>(key, controller);
    return ret;
  }

  Widget _profileNameWidget() {
    var ret;
    if (this.isEditing) {
      ret = this._editablePresenter(this.firstName, "change name here", "name");
    } else {
      ret = Text(
        this.firstName,
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
          border: Border(bottom: BorderSide(width: 2.5, color: Colors.white))),
    );
  }

  Widget _profilePanelList() {
    List<MyItems> items = this.items;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
        });
      },
      children: items.map((item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) =>
                _profilePanelHeader(item.header),
            isExpanded: item.isExpanded,
            body: _profilePanelBody(item.body));
      }).toList(),
    );
  }

  Widget _profilePanelHeader(String header) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 20.0, left: MediaQuery.of(context).size.width / 2.5),
      alignment: Alignment.centerLeft,
      child: Text(header,
          textAlign: TextAlign.center,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.black,
          )),
    );
  }

  Widget _profilePanelBody(String body) {
    return Column(
      children: <Widget>[
        Text(body),
        Text(body),
        Text(body),
        Text(body),
        Text(body),
      ],
    );
  }

  Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35),
    );
  }

  String _formValidation(String value) {
    //if (value.isEmpty) return ("Value can't be empty");
    return null;
  }

  void _onSaved(String value) {
    this.values.add(value);
  }

  Widget _spinner() {
    if (this.isBusy)
      return Positioned(child: CircularProgressIndicator(), top: 50, left: 50);
    return SizedBox(width: 0, height: 0);
  }

  void _connectivityHandler(bool value) {}
}

class ProfileInheritedWidget extends InheritedWidget {
  final ProfilePageState state;
  ProfileInheritedWidget({this.state, Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class MyItems {
  String header;
  String body;
  bool isExpanded;
  MyItems(String h, String b) {
    header = h;
    body = b;
    isExpanded = false;
  }
}

class ProfileClipper extends CustomClipper<Path> {
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

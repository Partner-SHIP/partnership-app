import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'dart:async';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  IRoutes      _routing = Routes();
  ProfilePageViewModel get viewModel => AViewModelFactory.register[_routing.profilePage];
  List<MyItems> items = [MyItems("Projects", "body"),MyItems("Partners", "body"),MyItems("Other", "body")];
  bool isEditing = false;
  String name = 'Tom Cruise';
  Animation<double> animation;
  AnimationController controller;
  var _image;

  @override
  void initState(){
    super.initState();
    this._image = NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg');
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 4)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        tooltip: "save changes",
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      );
    }
    else {
      ret = FloatingActionButton(
        onPressed: () => this.setState((){
          this.isEditing = !this.isEditing;
        }),
        child: Icon(Icons.edit, size: 35),
        tooltip: "edit",
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
            color: Colors.blue[600]
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(width: 0, height: 10),
              _profileNameWidget(),
              SizedBox(width: 0, height: 10),
              _profileDescriptionWidget(),
              _profilePanelList()
            ],
          ),
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

  Future _getImage() async {
    var image = await Future(null);
    setState(() {
      _image = _image;
    });
  }

  Widget _profileImageWidget(){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: _image,
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

  Widget _profileNameWidget(){
    var ret;
    if (this.isEditing) {
      ret = Row(
        children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: this.name,
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        hintText: "change name here",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        icon: Icon(Icons.edit, color: Colors.white)
                    ),
                  )
              ),
          ),
          FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.cancel, color: Colors.red),
              label: Text("cancel",
                style: TextStyle(
                    color: Colors.red),
              )
          )
        ],
      );
    }
    else {
      ret = Text(
        this.name,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.white),
      );
    }
    return ret;
  }

  Widget _profileDescriptionWidget(){
    return Container(
      padding: EdgeInsets.all(3),
        child:Text(
          """
      Id, and frappuccino sugar body skinny mocha affogato,
      grinder cappuccino half and half macchiato variety latte java whipped ut robusta.
      French press, froth, cup extra cup aftertaste decaffeinated, grounds filter to go caramelization acerbic extraction grounds cream foam café au lait dark arabica.
      Breve galão, saucer, dripper to go caffeine dark crema at breve, cultivar aftertaste whipped, spoon, organic mazagran shop irish beans.
      Cortado at, cortado medium galão cultivar turkish steamed viennese wings froth so rich frappuccino.
      Single origin, that siphon skinny turkish spoon that acerbic cinnamon to go skinny aftertaste as mug irish cinnamon iced organic filter arabica.
      Lungo skinny single origin extraction foam, eu, cinnamon coffee single shot shop turkish crema frappuccino macchiato crema aged.
      A frappuccino body aftertaste, seasonal instant breve arabica turkish, cream dripper qui java milk spoon dripper.
      """,
          softWrap: true,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontFamily: 'MontSerra',
          ),
        ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
  }

  Widget _profilePanelList(){
    List<MyItems> items = this.items;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded){

        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
        });
      },
      children: items.map((item){
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) => _profilePanelHeader(item.header),
          isExpanded: item.isExpanded,
          body: _profilePanelBody(item.body)
        );
      }).toList(),
    );
  }

  Widget _profilePanelHeader(String header){
    return Text(
      header,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: Colors.black,
      )
    );
  }
  Widget _profilePanelBody(String body){
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

}

class MyItems{
  String header;
  String body;
  bool isExpanded;
  MyItems(String h,String b){
    header = h;
    body = b;
    isExpanded = false;
  }
}

class ProfileClipper extends CustomClipper<Path>{
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
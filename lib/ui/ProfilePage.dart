import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  ProfilePageViewModel _viewModel = AViewModelFactory(Routes.profilePage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: ProfileClipper(),
            ),
            Positioned(
              child: Column(
                children: <Widget>[
                  this._profileImageWidget(),
                  SizedBox(height: 90.0),
                  this._profileNameWidget()
                ],
              ),
              width: 350.0,
              left: 30,
              top: MediaQuery.of(context).size.height / 5,
            ),
          ],)
    );
  }

  Widget _profileImageWidget(){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
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
    return Text(
    'Tom Cruise',
    style: TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat'),
    );
  }
}


class ProfileClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  IRoutes      _routing = Routes();
  ProfilePageViewModel get viewModel =>
      AViewModelFactory.register[_routing.profilePage];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600]
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width *2,
                                  height: MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/blue_texture.jpg'))
                                  ),
                              ),
                              Positioned(
                                child: _profileImageWidget(),
                                top: MediaQuery.of(context).size.height / 8,
                                left: MediaQuery.of(context).size.width / 3,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(width: 0, height: MediaQuery.of(context).size.height / 2.8),
                                  _profileNameWidget(),
                                  SizedBox(width: 0, height: 25),
                                  _profileDescriptionWidget(),
                                  _profileDescriptionWidget(),
                                  _profileDescriptionWidget()
                                ],
                              ),
                            ],
                          )
                      )
                    )
                  ],
                ),
              )
          )
    );
  }

  Widget _clipPathWidget(){
    return ClipPath(
      child: Container(
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
    softWrap: false,
    overflow: TextOverflow.fade,
    style: TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat',
    color: Colors.white),
    );
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
}

class ProfileClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    //path.lineTo(0.0, size.height / 2.0);
    //path.lineTo(size.width + 125, 0.0);
    path.lineTo(0.0, size.height / 6.0);
    path.lineTo(size.width / 2, size.height / 3.0);
    path.lineTo(size.width, size.height / 6.0);
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
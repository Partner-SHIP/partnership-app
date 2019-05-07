// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:partnership/utils/Routes.dart';
// import 'package:partnership/viewmodel/AViewModelFactory.dart';
// import 'package:partnership/viewmodel/SignUpPageViewModel.dart';
// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignUpPageViewModel.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'dart:ui';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  IRoutes _routing = Routes();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  final SignUpData _data = SignUpData();
  bool busy = false;
  bool _switch = false;
  StreamSubscription _connectivitySub;
  bool _termsChecked = false;
  SignUpPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signUpPage];

  void displaySuccessSnackBar(String snack) {
    var snackbar =
        SnackBar(content: Text(snack), duration: Duration(milliseconds: 5000));
    this._mainKey.currentState.showSnackBar(snackbar);
  }

  @override
  void initState() {
    super.initState();
    this._connectivitySub =
        viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose() {
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;

    // final topBar = AppBar(
    //   backgroundColor: Colors.lightBlueAccent.shade100,
    //   title: Text('Inscription'),
    // );

    // final signUpButton = Padding(
    //   padding: EdgeInsets.symmetric(vertical: 16.0),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(30.0),
    //     shadowColor: Colors.lightBlueAccent.shade100,
    //     elevation: 5.0,
    //     child: MaterialButton(
    //       minWidth: 200.0,
    //       height: 42.0,
    //       color: Colors.lightBlueAccent,
    //       child: Text('Je m\'inscris', style: TextStyle(color: Colors.white)),
    //       onPressed: () {
    //         if (this._formKey.currentState.validate() && _termsChecked) {
    //           this._formKey.currentState.save();
    //           setState(() {
    //             busy = true;
    //           });
    //           this.viewModel.signUpAction(this._data).then((value) {
    //             if (value) {
    //               var snackbar = SnackBar(
    //                   content: Text("SignUp successful!"),
    //                   duration: Duration(milliseconds: 5000));
    //               this._mainKey.currentState.showSnackBar(snackbar);
    //               this.viewModel.changeView(
    //                   route: this._routing.homePage, widgetContext: context);
    //             }
    //             setState(() {
    //               busy = false;
    //             });
    //           });
    //         }
    //       },
    //     ),
    //   ),
    // );

    // final formContainer = Container(
    //     padding: EdgeInsets.all(20.0),
    //     width: screenSize.width,
    //     child: Form(
    //       key: this._formKey,
    //       child: ListView(
    //         physics: NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         children: <Widget>[
    //           Image.asset(
    //             'assets/img/logo_partnership.png',
    //             height: 50,
    //           ),
    //           busy
    //               ? CircularProgressIndicator()
    //               : Container(width: 0, height: 0),
    //           TextFormField(
    //             validator: (value) {
    //               if (value.isEmpty) {
    //                 return ('Veuillez saisir un pseudo');
    //               }
    //               //TODO : regex pour le pseudal
    //               /* bool nicknameValid =
    //                     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //                         .hasMatch(value);
    //                 if (!nicknameValid) {
    //                   return ('Pseudo invalide');
    //                 }*/
    //             },
    //             onSaved: (value) => this._data.nickname = value,
    //             decoration: InputDecoration(
    //               icon: Icon(
    //                 Icons.supervisor_account,
    //                 color: Colors.grey,
    //               ),
    //               hintText: 'Votre pseudo',
    //             ),
    //           ),
    //           TextFormField(
    //               validator: (value) {
    //                 if (value.isEmpty) {
    //                   return ('Veuillez saisir une adresse email valide');
    //                 }
    //                 bool emailValid =
    //                     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //                         .hasMatch(value);
    //                 if (!emailValid) {
    //                   return ('Email invalide');
    //                 }
    //               },
    //               onSaved: (value) => this._data.email = value,
    //               keyboardType: TextInputType
    //                   .emailAddress, // Use email input type for emails.
    //               decoration: InputDecoration(
    //                 icon: Icon(
    //                   Icons.email,
    //                   color: Colors.grey,
    //                 ),
    //                 hintText: 'Une adresse email valide',
    //               )),
    //           TextFormField(
    //               validator: (value) {
    //                 if (value.isEmpty) {
    //                   return ('Veuillez saisir un mot de passe');
    //                 }
    //                 //TODO regex pour le mdp

    //                 /*bool emailValid =
    //                     RegExp('r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"')
    //                         .hasMatch(value);
    //                 if (!emailValid) {
    //                   return ('Mot de passe invalide');
    //                 }*/
    //               },
    //               onSaved: (value) => this._data.password = value,
    //               obscureText: true, // Use secure text for passwords.
    //               decoration: InputDecoration(
    //                 icon: Icon(
    //                   Icons.vpn_key,
    //                   color: Colors.grey,
    //                 ),
    //                 hintText: 'Mot de passe',
    //               )),
    //           TextFormField(
    //               validator: (value) {
    //                 if (value.isEmpty) {
    //                   return ('Veuillez confirmer votre mot de passe');
    //                 }
    //               },
    //               onSaved: (value) => this._data.confirmPassword = value,
    //               obscureText: true,
    //               decoration: InputDecoration(
    //                 icon: Icon(Icons.check_circle_outline, color: Colors.grey),
    //                 hintText: 'Confirmer le mot de passe',
    //               )),
    //           CheckboxListTile(
    //             activeColor: Theme.of(context).accentColor,
    //             title: RichText(
    //                 text: TextSpan(children: [
    //               TextSpan(
    //                   text: "J'accepte les ",
    //                   style: TextStyle(color: Colors.grey.shade700)),
    //               TextSpan(
    //                   text: "Conditions d'utilisations",
    //                   style: TextStyle(
    //                       color: Colors.blue, fontWeight: FontWeight.bold),
    //                   recognizer: TapGestureRecognizer()
    //                     ..onTap = () {
    //                       viewModel
    //                           .getAssetBundle()
    //                           .loadString('assets/texts/terms&conditions.txt')
    //                           .then((value) {
    //                         showDialog(
    //                             context: context,
    //                             builder: (BuildContext context) {
    //                               return AlertDialog(
    //                                 title: Text("Conditions d'utilisations"),
    //                                 content: SingleChildScrollView(
    //                                     child: Text(value)),
    //                                 actions: <Widget>[
    //                                   FlatButton(
    //                                     child: Text("Annuler"),
    //                                     onPressed: () =>
    //                                         Navigator.of(context).pop(),
    //                                   )
    //                                 ],
    //                               );
    //                             });
    //                       });
    //                     })
    //             ])),
    //             value: _termsChecked,
    //             onChanged: (bool value) =>
    //                 setState(() => _termsChecked = value),
    //             subtitle: !_termsChecked
    //                 ? Padding(
    //                     padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
    //                     child: Text(
    //                       'accord requis',
    //                       style:
    //                           TextStyle(color: Color(0xFFe53935), fontSize: 12),
    //                     ),
    //                   )
    //                 : null,
    //           ),
    //           Container(
    //             width: screenSize.width,
    //             child: signUpButton,
    //           ),
    //         ],
    //       ),
    //     ));

    // final bottomContainer = Container(
    //   child: Center(
    //     child: Column(
    //       children: <Widget>[
    //         Text(
    //           '-  Ou inscris-toi avec  -',
    //           style: TextStyle(color: Colors.blue, fontSize: 20),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             RaisedButton(
    //               child: Icon(FontAwesomeIcons.facebookF),
    //               onPressed: () {},
    //             ),
    //             RaisedButton(
    //               child: Icon(FontAwesomeIcons.google),
    //               onPressed: () {},
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    final signUpSwitcher = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () => setState(() => _switch = !_switch),
              child: AutoSizeText(
                'Email',
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: _switch ? Colors.grey : Colors.white,
                    fontFamily: 'Orkney',
                    fontSize: 15),
              ),
            ),
          ),
          ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 2,
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          )),
          Expanded(
            child: FlatButton(
              onPressed: () => setState(() => _switch = !_switch),
              child: AutoSizeText(
                'Réseaux Sociaux',
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: _switch ? Colors.white : Colors.grey,
                    fontFamily: 'Orkney',
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );

    final formContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.7,
      //color: Colors.blue,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    maxLength: 30,
                    validator: (String value){
                      if (value.isEmpty)
                        return 'nom manquant';
                    },
                    onSaved: (String value) => this._data.lastName = value,
                    decoration: InputDecoration(
                        hintText: 'Votre Nom',
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney"),
                        icon: Padding(
                            child: Icon(Icons.account_circle,
                                size: 30, color: Colors.white),
                            padding: EdgeInsets.only(top: 25)))),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5)),
            Padding(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    maxLength: 30,
                    validator: (String value){
                      if (value.isEmpty)
                        return 'prénom manquant';
                    },
                    onSaved: (String value) => this._data.firstName = value,
                    decoration: InputDecoration(
                        hintText: 'Votre prénom',
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney"),
                        icon: Padding(
                            child: Icon(Icons.arrow_forward,
                                size: 30, color: Colors.white),
                            padding: EdgeInsets.only(top: 25)))),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5)),
            Padding(
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    maxLength: 30,
                    validator: (String value){
                      if (value.isEmpty)
                        return 'email manquant';
                    },
                    onSaved: (String value) => this._data.email = value,
                    decoration: InputDecoration(
                        hintText: 'Addresse email valide',
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney"),
                        icon: Padding(
                            child:
                                Icon(Icons.mail, size: 30, color: Colors.white),
                            padding: EdgeInsets.only(top: 25)))),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5)),
            Padding(
                child: TextFormField(
                  maxLines: 1,
                  maxLength: 30,
                  obscureText: true,
                  validator: (String value){
                    if (value.isEmpty)
                      return 'mot de passe manquant';
                  },
                  onSaved: (String value) => this._data.password = value,
                  decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      icon: Padding(
                          child: Icon(Icons.vpn_key,
                              size: 30, color: Colors.white),
                          padding: EdgeInsets.only(top: 25))),
                ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5)),
            Padding(
                child: TextFormField(
                    maxLines: 1,
                    maxLength: 30,
                    obscureText: true,
                    validator: (String value){
                      if (value.isEmpty)
                        return 'confirmation manquante';
                    },
                    onSaved: (String value) => this._data.confirmPassword = value,
                    decoration: InputDecoration(
                        hintText: 'Confirmer votre mot de passe',
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney"),
                        icon: Padding(
                            child: Icon(Icons.check,
                                size: 30, color: Colors.white),
                            padding: EdgeInsets.only(top: 25)))),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5)),
            Padding(
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Theme.of(context).accentColor,
                  title: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "J'accepte les ",
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: "Conditions d'utilisations",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                viewModel
                                    .getAssetBundle()
                                    .loadString('assets/texts/terms&conditions.txt')
                                    .then((value) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Conditions d'utilisations"),
                                          content: SingleChildScrollView(
                                              child: Text(value)),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Annuler"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        );
                                      });
                                });
                              })
                      ]
                      )
                  ),
                  value: _termsChecked,
                  onChanged: (bool value) =>
                      setState(() => _termsChecked = value),
                  subtitle: !_termsChecked
                      ? Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: Text(
                      'Votre accord est requis',
                      style: TextStyle(
                          color: Color(0xFFe53935), fontSize: 12),
                    ),
                  )
                      : null,
                ),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5
              ),
            ),
          ],
        ),
      ),
    );

    final Widget signUpButtonContainer = Container(
        child: Padding(
      child: RoundedGradientButton(
          child: AutoSizeText(
            'INSCRIPTION',
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontFamily: 'Orkney'),
          ),
          callback: (){
            if (this._formKey.currentState.validate() && _termsChecked){
              this._formKey.currentState.save();
               setState(() {
                 busy = true;
               });
               this.viewModel.signUpAction(this._data).then((value) {
                 if (value) {
                   this.viewModel.changeView(
                       route: this._routing.homePage, widgetContext: context);
                 }
                 setState(() {
                   busy = false;
                 });
               });
            }
          },
          increaseWidthBy: 80,
          increaseHeightBy: 10),
      padding: EdgeInsets.only(top: 0),
    ));

    final providersContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      //color: Colors.pink,
      child: Stack(
        children: <Widget>[
          Center(
              child: ClipRect(
                  child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 2,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ))),
          Center(
              child: ClipRect(
                  child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.height / 3,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_google.png',
                        width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_fb.png',
                        width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_insta.png',
                        width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_twitter.png',
                        width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );

    //   return Scaffold(
    //       resizeToAvoidBottomPadding: true,
    //       appBar: topBar,
    //       backgroundColor: Colors.grey[300],
    //       key: this._mainKey,
    //       body: SingleChildScrollView(
    //           child: Column(
    //         children: <Widget>[formContainer, bottomContainer],
    //       )));
    // }

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
            child: ThemeContainer(
                context,
                Column(
                  children: <Widget>[
                    Padding(
                      child: Image.asset('assets/img/partnership_logo.png',
                          width: 110, height: 110),
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                    ),
                    AutoSizeText(
                      'Inscription',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: 'Orkney'),
                    ),
                    signUpSwitcher,
                    Padding(
                      child: _switch ? providersContainer : formContainer,
                      padding: EdgeInsets.only(top: 1),
                    ),
                    signUpButtonContainer,
                  ],
                ))));
  }

  void _connectivityHandler(bool value) {}
}

import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignInPageViewModel.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';
import 'dart:ui';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInData           _data = SignInData();
  bool                       _switch = false;
  StreamSubscription _connectivitySub;
  IRoutes _routing = Routes();
  SignInPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signInPage];


  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Builder(
            builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  splashColor: Colors.transparent,
                  child: SafeArea(
                      top: false,
                      child: ThemeContainer(
                          context,
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  child: Image.asset('assets/img/partnership_logo.png', width:110, height: 110),
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                ),
                                AutoSizeText(
                                  'Connexion',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontFamily: 'Orkney'
                                  ),
                                ),
                                createLoginSwitcher(context),
                                Padding(
                                  child: _switch ? createProvidersContainer(context) : createFormContainer(context),
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                _switch ? Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  height: 75,
                                  child: AutoSizeText('Bientôt disponible'),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white.withOpacity(0.3),

                                  ),
                                ) : SizedBox(width: 0, height: 0)
                              ],
                            ),
                          )
                      )
                  )
              );
            }
        )
    );
  }
  
  Widget createLoginSwitcher(BuildContext context){
    final loginSwitcher = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
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
                    fontSize: 15
                ),
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
              )
          ),
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
                    fontSize: 15
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return loginSwitcher;
  }

  Widget createFormContainer(BuildContext context){
    final formContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: new Theme(
        data: new ThemeData(
          hintColor: Colors.white70
        ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    validator: (String value){
                      if (value.isEmpty) {
                        return ('Veuillez saisir une adresse email valide');
                      }
                      bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return ('Email invalide');
                      }
                    },
                    onSaved: (value) => this._data.email = value,
                    decoration: InputDecoration(
                        hintText: 'Adresse email valide',
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney"),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(color: Colors.white70)
                          ),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
            ),
                        icon: Padding(
                            child: Icon(Icons.mail, size: 30, color: Colors.white),
                            padding: EdgeInsets.only(top: 5)
                        )
                    )
                ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8
                )
            ),
            Padding(
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  obscureText: true,
                  validator: (String value){
                    if (value.isEmpty) {
                      return ('Veuillez saisir un mot de passe');
                    }
                  },
                  onSaved: (value) => this._data.password = value,
                  decoration: InputDecoration(
                      hintText: 'Mot de passe',
                                              enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(color: Colors.white70)
                          ),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()
            ),
                      icon: Padding(
                          child: Icon(Icons.vpn_key, size: 30, color: Colors.white),
                          padding: EdgeInsets.only(top: 5)
                      )
                  ),
                ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8
                )
            ),
            Padding(
              child: RoundedGradientButton(
                  child: AutoSizeText(
                    'CONNEXION',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Orkney'
                    ),
                  ),
                  callback: () {
                    if (_formKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Material(
                            type: MaterialType.transparency,
                            child: Center(
                                child: FlareActor('assets/animations/Liquid Loader.flr', animation: 'Untitled')
                            ),
                          );
                        },
                      );
                      this._formKey.currentState.save();
                      this.viewModel.signInAction(this._data).then((value){
                        Navigator.of(context).pop();
                        if (value) {
                          this.viewModel.afterSignIn(context);
                        }
                        else {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Connexion échouée, veuillez vérifier vos identifiants"),
                          ));
                        }
                      });
                    }
                  },
                  increaseWidthBy: 80,
                  increaseHeightBy: 10
              ),
              padding: EdgeInsets.only(top: 40),
            ),
          ],
        ),
      )
      ),
    );
    return formContainer;
  }

  Widget createProvidersContainer(BuildContext context){
    final providersContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: <Widget>[
          Center(child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              )
          )),
          Center(child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.height / 3,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              )
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_google.png', width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_fb.png', width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_insta.png', width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_twitter.png', width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
    return providersContainer;
  }

  void _connectivityHandler(bool value) {

  }
}


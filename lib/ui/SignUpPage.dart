import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SignUpPageViewModel.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';
import 'dart:ui';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  IRoutes _routing = Routes();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpData _data = SignUpData();
  bool _switch = false;
  StreamSubscription _connectivitySub;
  bool _termsChecked = false;
  SignUpPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signUpPage];

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
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Builder(builder: (BuildContext context){
          return InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            splashColor: Colors.transparent,
            child: SafeArea(
                top:false,
                child: ThemeContainer(
                    context,
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            child: Image.asset('assets/img/partnership_logo.png',
                                width: 110, height: 110),
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                          ),
                          Padding(
                            child: AutoSizeText(
                              'Inscription',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Orkney'),
                            ),
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                          ),
                          createFormContainer(context),
                          createSignUpButtonContainer(context),
                        ],
                      ),
                    )
                )
            ),
          );
        })
    );
  
  }

  Widget createSignUpSwitcher(BuildContext context){
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
    return signUpSwitcher;
  }

  Widget createFormContainer(BuildContext context){
    final formContainer = Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    maxLength: 30,
                    validator: (String value){
                      if (value.isEmpty)
                        return 'email manquant';
                    },
                    onSaved: (String value) => this._data.email = value,
                    decoration: InputDecoration(
                        hintText: 'Adresse email valide',
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
                  style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Padding(
                  child: Center(
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
                  ),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6.5)
              ),
            ),

          ],
        ),
      ),
    );
    return formContainer;
  }

  Widget createSignUpButtonContainer(BuildContext context){
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
                  this.viewModel.signUpAction(this._data).then((value) {
                    Navigator.of(context).pop();
                    if (value) {
                      this.viewModel.changeView(
                          route: this._routing.homePage, widgetContext: context);
                    }
                    else {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Une erreur est survenue, veuillez réessayer"),
                      ));
                    }
                  });
                }
              },
              increaseWidthBy: 80,
              increaseHeightBy: 10),
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        )
    );
    return signUpButtonContainer;
  }

  Widget createProvidersContainer(BuildContext context){
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
    return providersContainer;
  }

  void _connectivityHandler(bool value) {}
}

import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SearchMemberPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class SearchMemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchMemberPageState();
  }
}


class SearchMemberPageState extends State<SearchMemberPage> {
  IRoutes      _routing = Routes();
  SearchMemberPageViewModel get viewModel => AViewModelFactory.register[_routing.searchMemberPage];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: buildEndDrawer(context: context, viewModel: viewModel, searchMember: false),
        ),
        body: Builder(builder: (BuildContext context){
          viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.searchMemberPage));
          return SafeArea(
            top: false,
            child: ThemeContainer(context,
              Column(
                children: <Widget>[
                  pageHeader(context, 'recherche d\'utilisateurs'),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 110,
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('profiles').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              return new Scrollbar (
                                  child: ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (context, index){
                                        return new CustomCardState(snapshot.data.documents[index]);
                                      }
                                  )
                              );
                          }
                        },
                      ))
                ],
              ),
            ),
          );
        })
    );
  }
}

class CustomCardState extends StatefulWidget {
  CustomCardState(this.document);
  final DocumentSnapshot document;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CustomCard(
      firstName: document['firstName'],
      lastName: document['lastName'],
      cityLocation: document['cityLocation'],
      studies: document['studies'],
      uid: document['uid'],
      rec_contacts: document['rec_contacts'],
      contacts: document['contacts'],
    );
  }
}

class CustomCard extends State<CustomCardState> {
  CustomCard({@required this.firstName, this.lastName, this.cityLocation, this.studies, this.uid, this.rec_contacts, this.contacts});

  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;

  final String firstName;
  final String lastName;
  final String cityLocation;
  final String studies;
  final String uid;
  final rec_contacts;
  final contacts;
  String status = "4";
  Icon icons = new Icon(Icons.refresh);

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection("profiles").document(coordinator.getLoggedInUser().uid).snapshots().listen((onValue){
      List contactsList = onValue.data["contacts"];
      List recContactsList = onValue.data["rec_contacts"];
      List sendContactsList = onValue.data["send_contacts"];
      setState(() {
        if (contactsList != null && contactsList.contains(this.uid)) {
          status = "0";
        }
        else if (recContactsList != null && recContactsList.contains(this.uid)) {
          status = "1";
        }
        else if (sendContactsList != null && sendContactsList.contains(this.uid)) {
          status = "2";
        }
        else {
          status = "3";
        }
      });
    });
  }

  void  acceptContact(String userUid){
    Firestore.instance.collection("profiles").document(myUid).updateData({"rec_contacts": FieldValue.arrayRemove([userUid])}).then((onValue){
      Firestore.instance.collection("profiles").document(myUid).updateData({"contacts": FieldValue.arrayUnion([userUid])});
    });
    Firestore.instance.collection("profiles").document(userUid).updateData({"send_contacts": FieldValue.arrayRemove([myUid])}).then((onValue){
      Firestore.instance.collection("profiles").document(userUid).updateData({"contacts": FieldValue.arrayUnion([myUid])});
    });
  }

  void  removeContact(String userUid){
    /*Firestore.instance.collection("profiles").document(myUid).snapshots().map((convert){
      List list = convert.data[];
    });*/
    Firestore.instance.collection("profiles").document(myUid).updateData({"contacts": FieldValue.arrayRemove([userUid])});
    Firestore.instance.collection("profiles").document(userUid).updateData({"contacts": FieldValue.arrayRemove([myUid])});
  }

  Future<void> cancelContactAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajout de contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Voulez vous annuler l'invitation avec " + firstName + " " + lastName + " ?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                Firestore.instance.collection("profiles").document(myUid).updateData({"send_contacts": FieldValue.arrayRemove([this.uid])});
                Firestore.instance.collection("profiles").document(this.uid).updateData({"rec_contacts": FieldValue.arrayRemove([myUid])});
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> acceptContactAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajout de contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous ajouter ' + firstName + " " + lastName + " à vos contacts ?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Accepter'),
              onPressed: () {
                acceptContact(this.uid);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Refuser'),
              onPressed: () {
                Firestore.instance.collection("profiles").document(myUid).updateData({"rec_contacts": FieldValue.arrayRemove([this.uid])});
                Firestore.instance.collection("profiles").document(this.uid).updateData({"send_contacts": FieldValue.arrayRemove([myUid])});                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> removeContactAlertDialog(String userUid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression de contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous supprimer ' + firstName + " " + lastName + " de vos contacts ?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                removeContact(this.uid);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget get memberImage {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage('https://marineprofessionals.com/wp-content/uploads/2018/12/anonymous.png'),
        ),
      ),
    );
  }

  /*Wrap(
  //crossAxisAlignment: CrossAxisAlignment.start,
  //mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: <Widget>[
  Text(firstName + ' ' + lastName, style: TextStyle(
  fontSize: 20,
  fontFamily: 'Orkney',
  fontWeight: FontWeight.bold,
  color: Colors.black87,
  )
  ),
  Text(cityLocation + ' / ' + studies, style: TextStyle(
  fontSize: 15,
  fontFamily: 'Orkney',
  fontWeight: FontWeight.normal,
  color: Colors.black87,
  ),
  ),
  IconButton(icon: Icon(Icons.add, color: Colors.indigo), onPressed: null),
  ],
  ),*/

  Widget get memberCard {
    Coordinator coordinator = new Coordinator();
    String myUid = coordinator.getLoggedInUser().uid;
    List rec = new List();
    List contacts = this.contacts;
    MaterialColor colors;
    //rec.addAll();
    /* if (rec.contains(this.uid) == true)
      colors = Colors.indigo;
    else
      colors = Colors.transparent;*/
    //return Container(
    child: return new Card(
      color: Colors.white,
      child: ListTile(
        title:  Text((firstName ?? 'undefined') + ' ' + (lastName ?? 'undefined'), style: TextStyle(
          fontSize: 20,
          fontFamily: 'Orkney',
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        )
        ),
        subtitle: Text(this.formatCardInfo(), style: TextStyle(
          fontSize: 15,
          fontFamily: 'Orkney',
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
        ),
        trailing: IconButton(
            icon: Icon(icons.icon, color: Colors.indigoAccent),
            onPressed: () {
              if (status == "0") {
                removeContactAlertDialog(this.uid);
              }
              else if (status == "1") {
                acceptContactAlertDialog();
              }
              else if (status == "2") {
                cancelContactAlertDialog();
              }
              else if (status == "3"){
                Firestore.instance.collection("profiles")
                    .document(myUid)
                    .updateData(
                    {"send_contacts": FieldValue.arrayUnion([this.uid])});
                Firestore.instance.collection("profiles")
                    .document(this.uid)
                    .updateData(
                    {"rec_contacts": FieldValue.arrayUnion([myUid])});
              }
            }
        ),
      ),
    );
    //);
  }

  String formatCardInfo(){
    String undefinedCity = 'Location non renseignée';
    String undefinedStudies = 'Etudes non renseignées';
    const String separator = ' / ';
    String ret;
    (this.cityLocation != null && this.cityLocation.isNotEmpty) ? ret = this.cityLocation+separator : ret = undefinedCity+separator;
    (this.studies != null && this.studies.isNotEmpty) ? ret = this.studies+separator : ret = undefinedStudies+separator;
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    if (status == "0") {
      icons = new Icon(Icons.contacts);
    }
    else if (status == "1") {
      icons = new Icon(Icons.undo);
    }
    else if (status == "2") {
      icons = new Icon(Icons.send);
    }
    else if (status == "3"){
      icons = new Icon(Icons.add);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        //height: 115.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              //left: 50.0,
              child: memberCard,
            ),
            Positioned(top: 7.5, child: memberImage),
          ],
        ),
      ),
    );
  }
}
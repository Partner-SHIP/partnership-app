import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SearchMemberPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title:  Text(firstName + ' ' + lastName, style: TextStyle(
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
            icon: Icon(Icons.add, color: Colors.indigoAccent),
            onPressed: () {
      //        if (rec.contains(myUid) == true) {
        //        rec.remove(myUid);
                Firestore.instance.collection("profiles")
                    .document(myUid)
                    .updateData(
                    {"send_contacts": FieldValue.arrayUnion([this.uid])});
                Firestore.instance.collection("profiles")
                    .document(this.uid)
                    .updateData(
                    {"rec_contacts": FieldValue.arrayUnion([myUid])});
          //    }
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
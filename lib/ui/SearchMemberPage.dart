import 'package:flutter/material.dart';
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
                              return new ListView(
                                children: snapshot.data.documents.map((DocumentSnapshot document) {
                                  return new CustomCard(
                                    firstName: document['firstName'],
                                    lastName: document['lastName'],
                                    cityLocation: document['cityLocation'],
                                    studies: document['studies'],
                                    uid: document['uid'],
                                  );
                                }).toList(),
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

class CustomCard extends StatelessWidget {
  CustomCard({@required this.firstName, this.lastName, this.cityLocation, this.studies, this.uid});

  final firstName;
  final lastName;
  final cityLocation;
  final studies;
  final uid;

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

Widget get memberCard {
  return Container(
    width: 290.0,
    height: 115.0,
    child: Card(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 64.0,
        ),
        child: Wrap(
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
        ),
      ),
      
    ),
  );
}
 @override
  Widget build(BuildContext context) {
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      height: 115.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50.0,
            child: memberCard,
          ),
          Positioned(top: 7.5, child: memberImage),
        ],
      ),
    ),
  );
  }
}
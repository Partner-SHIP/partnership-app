import 'package:partnership/utils/FBCollections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

abstract class PayloadsFactory
{
  factory PayloadsFactory(String collection){
    Payload payload;
    switch (collection){
      case FBCollections.membership:
        payload = MembershipPayload();
        break;
      case FBCollections.profiles:
        payload = ProfilePayload();
        break;
      default:
        break;
    }
    return payload;
  }
}

enum PayloadAction {WRITE, UPDATE, NOTHING}

abstract class Payload implements PayloadsFactory {
  final Map<String, Tuple2<dynamic, PayloadAction>> _parameters = <String, Tuple2<dynamic, PayloadAction>>{};
  void _updateParameters();
  Map<String, dynamic> getDataToWrite(){
    Map<String, dynamic> ret = <String, dynamic>{};
    this._updateParameters();
    this._parameters.forEach((key, tuple){
      if (tuple.item2 == PayloadAction.WRITE)
        ret[key] = tuple.item1;
    });
    return ret;
  }
  Map<String, dynamic> getDataToUpdate(){
    Map<String, dynamic> ret = <String, dynamic>{};
    this._updateParameters();
    this._parameters.forEach((key, tuple){
      if (tuple.item2 == PayloadAction.UPDATE)
        ret[key] = tuple.item1;
    });
    return ret;
  }
}

class MembershipPayload extends Payload {
  Tuple2<Timestamp, PayloadAction>         _dateOfMembership = Tuple2<Timestamp, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<bool, PayloadAction>              _isGroupAdmin = Tuple2<bool, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<Timestamp, PayloadAction>         _lastActivity = Tuple2<Timestamp, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<Timestamp, PayloadAction>         _lastConnection = Tuple2<Timestamp, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<DocumentReference, PayloadAction> _relatedProject = Tuple2<DocumentReference, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>            _uid = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  set dateOfMembership(Tuple2<Timestamp, PayloadAction> data) => this._dateOfMembership = data;
  set isGroupAdmin(Tuple2<bool, PayloadAction> data) => this._isGroupAdmin = data;
  set lastActivity(Tuple2<Timestamp, PayloadAction> data) => this._lastActivity = data;
  set lastConnection(Tuple2<Timestamp, PayloadAction> data) => this._lastConnection = data;
  set relatedProject(Tuple2<DocumentReference, PayloadAction> data) => this._relatedProject = data;
  set uid(Tuple2<String, PayloadAction> data) => this._uid = data;
  MembershipPayload();
  @override
  void _updateParameters() {
    this._parameters['dateOfMembership'] = this._dateOfMembership;
    this._parameters['isGroupAdmin'] = this._isGroupAdmin;
    this._parameters['lastActivity'] = this._lastActivity;
    this._parameters['lastConnection'] = this._lastConnection;
    this._parameters['relatedProject'] = this._relatedProject;
    this._parameters['uid'] = this._uid;
  }
}

class ProfilePayload extends Payload {
  Tuple2<String, PayloadAction>    _description = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>    _firstName = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>    _lastName = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<GeoPoint, PayloadAction>  _location = Tuple2<GeoPoint, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<int, PayloadAction>       _locationPrivacyLevel = Tuple2<int, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>    _nickname = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>    _photoUrl = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<int, PayloadAction>       _profilePrivacyLevel = Tuple2<int, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<Timestamp, PayloadAction> _registrationDate = Tuple2<Timestamp, PayloadAction>(null, PayloadAction.NOTHING);
  Tuple2<String, PayloadAction>    _uid = Tuple2<String, PayloadAction>(null, PayloadAction.NOTHING);
  set description(Tuple2<String, PayloadAction> data) => this._description = data;
  set firstName(Tuple2<String, PayloadAction> data) => this._firstName = data;
  set lastName(Tuple2<String, PayloadAction> data) => this._lastName = data;
  set location(Tuple2<GeoPoint, PayloadAction> data) => this._location = data;
  set locationPrivacyLevel(Tuple2<int, PayloadAction> data) => this._locationPrivacyLevel = data;
  set nickname(Tuple2<String, PayloadAction> data) => this._nickname = data;
  set photoUrl(Tuple2<String, PayloadAction> data) => this._photoUrl = data;
  set profilePrivacyLevel(Tuple2<int, PayloadAction> data) => this._profilePrivacyLevel = data;
  set registrationDate(Tuple2<Timestamp, PayloadAction> data) => this._registrationDate = data;
  set uid(Tuple2<String, PayloadAction> data) => this._uid = data;
  ProfilePayload();
  @override
  void _updateParameters() {
    this._parameters['description'] = this._description;
    this._parameters['firstname'] = this._firstName;
    this._parameters['lastname'] = this._lastName;
    this._parameters['location'] = this._location;
    this._parameters['locationPrivacyLevel'] = this._locationPrivacyLevel;
    this._parameters['nickname'] = this._nickname;
    this._parameters['photoUrl'] = this._photoUrl;
    this._parameters['profilePrivacyLevel'] = this._profilePrivacyLevel;
    this._parameters['registrationDate'] = this._registrationDate;
    this._parameters['uid'] = this._uid;
  }
}


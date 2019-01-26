import 'package:partnership/utils/FBCollections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

abstract class Payload implements PayloadsFactory {
  final Map<String, dynamic> _parameters = <String, dynamic>{};
  Map<String, dynamic> getPayload();
}

class MembershipPayload extends Payload {
  Timestamp         dateOfMembership;
  bool              isGroupAdmin;
  Timestamp         lastActivity;
  Timestamp         lastConnection;
  DocumentReference relatedProject;
  String            uid;
  MembershipPayload(){
    this.dateOfMembership = null;
    this.isGroupAdmin = null;
    this.lastActivity = null;
    this.lastConnection = null;
    this.relatedProject = null;
    this.uid = null;
  }
  @override
  Map<String, dynamic> getPayload() {
    this._parameters['dateOfMembership'] = this.dateOfMembership;
    this._parameters['isGroupAdmin'] = this.isGroupAdmin;
    this._parameters['lastActivity'] = this.lastActivity;
    this._parameters['lastConnection'] = this.lastConnection;
    this._parameters['relatedProject'] = this.relatedProject;
    this._parameters['uid'] = this.uid;
    return this._parameters;
  }
}

class ProfilePayload extends Payload {
  String    description;
  String    firstname;
  String    lastname;
  GeoPoint  location;
  int       locationPrivacyLevel;
  String    nickname;
  String    photoUrl;
  int    profilePrivacyLevel;
  Timestamp registrationDate;
  String    uid;
  ProfilePayload(){
    this.description = null;
    this.firstname = null;
    this.lastname = null;
    this.location = null;
    this.locationPrivacyLevel = null;
    this.nickname = null;
    this.photoUrl = null;
    this.profilePrivacyLevel = null;
    this.registrationDate = null;
    this.uid = null;
  }
  @override
  Map<String, dynamic> getPayload() {
    this._parameters['description'] = this.description;
    this._parameters['firstname'] = this.firstname;
    this._parameters['lastname'] = this.lastname;
    this._parameters['location'] = this.location;
    this._parameters['locationPrivacyLevel'] = this.locationPrivacyLevel;
    this._parameters['nickname'] = this.nickname;
    this._parameters['photoUrl'] = this.photoUrl;
    this._parameters['profilePrivacyLevel'] = this.profilePrivacyLevel;
    this._parameters['registrationDate'] = this.registrationDate;
    this._parameters['uid'] = this.uid;
    return this._parameters;
  }

}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/AddContactModel.dart';

class AddContactViewModel extends AViewModel {
/*  AddContactViewModel _addContactModel;
  AddContactViewModel(String route){
    super.initModel(route);
    _addContactModel = super.abstractModel;*/

  AddContactModel _model;

  Member getMember() {
    return (_model.member);
  }

  List<Member> getListMember() {
    return (_model.members);
  }

  void supMember(int index){
    _model.members.removeAt(index);
  }

  void contactsChange(List myContacts){
    for (int i = _model.members.length; i < myContacts.length;i++){
      Firestore.instance.document('profiles/' + myContacts[i]).snapshots().listen((onData) {
        this.addMember(onData);
        print(onData.data['firstName']);
      } );
    }
  }
  void delete(){
    if (_model.members.isNotEmpty)
      _model.members.removeRange(0, _model.members.length);
  }

  void addMember(var f) {
    if (f.data['firstName'] != null && f.data['firstName'] != "" && f.data['uid'] != null && f.data['uid'] != "") {
      _model.members.add(
          Member(fullName: f.data['firstName'], email: '', uid: f.data['uid']));
    }
  }

  void setListMember(Member member) {
    _model.member = member;
  }

  AddContactViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  AddContactModel get model => this._model;

  String test() {
    return "OK";
  }
}

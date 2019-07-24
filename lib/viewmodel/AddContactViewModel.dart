import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/AddContactModel.dart';




class AddContactViewModel extends AViewModel {
/*  AddContactViewModel _addContactModel;
  AddContactViewModel(String route){
    super.initModel(route);
    _addContactModel = super.abstractModel;*/

    AddContactModel                  _model;
    Member getMember(){
     return (_model.member);
    }
    List<Member>  getListMember(){
      return  (_model.listMember);
    }
    void  addMember(var f){
      if (f.data['firstName'] != null) {
        _model.members.add(Member(
            fullName: f.data['firstName'], email: '', uid: f.data['uid']));
      }
    }

    void  setListMember(Member member)
    {
      _model.member = member;
    }

    AddContactViewModel(String route) {
      super.initModel(route);
      this._model = super.abstractModel;
    }
    AddContactModel get model => this._model;

    String test(){
      return "OK";
    }
  }
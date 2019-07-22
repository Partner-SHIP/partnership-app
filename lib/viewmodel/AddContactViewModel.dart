import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/AddContactModel.dart';




class AddContactViewModel extends AViewModel {
/*  AddContactViewModel _addContactModel;
  AddContactViewModel(String route){
    super.initModel(route);
    _addContactModel = super.abstractModel;*/

    AddContactModel                  _model;

    AddContactViewModel(String route) {
      super.initModel(route);
      this._model = super.abstractModel;
    }
    AddContactModel get model => this._model;

    String test(){
      return "OK";
    }
  }
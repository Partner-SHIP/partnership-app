import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SearchMemberPageModel.dart';

class SearchMemberPageViewModel extends AViewModel {
  SearchMemberPageModel _model;
  SearchMemberPageViewModel(String route){
    super.initModel(route);
    this._model = super.abstractModel;
  }
  SearchMemberPageModel get model => this. _model; 
  String get photoUrl => this.model.photoUrl;
}
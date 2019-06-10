import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/SearchMemberPageModel.dart';

class SearchMemberPageViewModel extends AViewModel {
  SearchMemberPageModel _searchMemberModel;
  SearchMemberPageViewModel(String route){
    super.initModel(route);
    _searchMemberModel = super.abstractModel;
  }
}
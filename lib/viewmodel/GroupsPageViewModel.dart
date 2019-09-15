import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/GroupsPageModel.dart';

class GroupsPageViewModel extends AViewModel {
  GroupsPageModel _model;

  GroupsPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  GroupsPageModel get model => this._model;
}

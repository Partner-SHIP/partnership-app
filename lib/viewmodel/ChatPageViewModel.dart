import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ChatPageModel.dart';

class ChatPageViewModel extends AViewModel {
  ChatPageModel _chatModel;
  ChatPageViewModel(String route){
    super.initModel(route);
    _chatModel = super.abstractModel;
  }
}
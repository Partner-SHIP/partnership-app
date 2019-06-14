import 'package:partnership/model/AModel.dart';

class SignUpPageModel extends AModel {
  SignUpPageModel(): super();

  void createProfile(Map<String, String> args, String uid){
    this.apiClient.postProfile(header: {'uid':uid}, args: args);
  }

}
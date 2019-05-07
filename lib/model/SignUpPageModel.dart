import 'package:partnership/model/AModel.dart';
import 'package:partnership/utils/FBCollections.dart';

class SignUpPageModel extends AModel {
  SignUpPageModel(): super(const <String>[FBCollections.profiles, FBCollections.membership/*Collections needed here*/]);
}
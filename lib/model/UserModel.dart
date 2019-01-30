import 'package:partnership/model/AModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends AModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  UserModel();
  void signIn(String mail, String pass, Function onResult) async {
    try {
      _user = await _firebaseAuth.signInWithEmailAndPassword(email: mail, password: pass);
      onResult(true, null);
    }
    catch (e) {
      onResult(false, e.toString());
    }
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModule {
  static final AuthenticationModule instance = AuthenticationModule._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser       _loggedInUser;

  factory AuthenticationModule(){
      return instance;
  }
  AuthenticationModule._internal();

  //Email Authentification
  Future<bool> loginByEmail(String email, String password) async {
    try {
      final FirebaseUser user = await this._auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser currentUser = await this._auth.currentUser();
      assert(user != null);
      assert(user.uid == currentUser.uid);
      this._loggedInUser = currentUser;
      return true;
    }
    catch (error){
      print(error);
      return false;
    }
  }

  // Email SignUp
  Future<FirebaseUser> signUpByEmail(email, password) async {
    try{
      final FirebaseUser user = await this._auth.createUserWithEmailAndPassword(email: email, password: password);
      assert(user != null);
      assert(await user.getIdToken() != null);
      return (user);
    }
    catch(error){
      print(error);
      return null;
    }
  }
}

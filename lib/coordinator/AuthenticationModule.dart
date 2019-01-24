import 'dart:async';
import 'package:flutter/foundation.dart';
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
  Future<bool> loginByEmail({@required String userEmail, @required String userPassword}) async {
    try {
      assert(userEmail != null && userEmail.isNotEmpty, "userMail must be a valid Email");
      assert(userPassword != null && userPassword.isNotEmpty, "userPassword must be a valid Password");
      final FirebaseUser user = await this._auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      final FirebaseUser currentUser = await this._auth.currentUser();
      assert(user != null, "FirebaseUser is null");
      assert(await user.getIdToken() != null, "FirebaseUser.getIdToken() returned null");
      assert(user.uid == currentUser.uid, "Mismatch between FirebaseUser.uid and currentUser.uid");
      this._loggedInUser = currentUser;
      return true;
    }
    catch (error){
      print(error);
      return false;
    }
  }

  // Email SignUp
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword}) async {
    try{
      assert(newEmail != null && newEmail.isNotEmpty, "newEmail must be a valid Email");
      assert(newPassword != null && newPassword.isNotEmpty, "newPassword must be a valid Password");
      final FirebaseUser user = await this._auth.createUserWithEmailAndPassword(email: newEmail, password: newPassword);
      assert(user != null, "FirebaseUser is null");
      assert(await user.getIdToken() != null, "FirebaseUser.getIdToken() returned null");
      return (user);
    }
    catch(error){
      print(error);
      return null;
    }
  }
}

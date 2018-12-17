import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Auth();

  void _checkEmailCredentials(String email, String password) {}

  //Email Authentification
  Future<FirebaseUser> handleLoginInEmail(String email, String password) async {
    //_checkEmailCredentials(email, password);

    final FirebaseUser user =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return (user);
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    final FirebaseUser user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    assert(user != null);
    assert(await user.getIdToken() != null);

    return (user);
  }
}

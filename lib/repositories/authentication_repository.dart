import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository{
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<void> signIn() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }



}
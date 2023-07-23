import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email,String password);
  Future<String?> currentUser();
  Future<void> signOut();
  Stream<String?> get onAuthStateChanged;
}

class Auth implements BaseAuth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((User? user) => user?.uid);
  }

  @override
  Future<String> signInWithEmailAndPassword(String email,String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  @override
  Future<String> currentUser() async {
    User user = await _firebaseAuth.currentUser!;
    return user.uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


}

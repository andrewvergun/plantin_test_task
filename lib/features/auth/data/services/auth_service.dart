import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      // save firebase credential token to shared preferences
      if (user != null) {
        final token = await user.getIdToken();
        prefs.setString('firebaseCredential', token!);
        print('Firebase credential: ${prefs.getString('firebaseCredential')}');
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Authentication error: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

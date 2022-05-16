// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizlet/utils/firestore_url.dart';
import 'package:quizlet/services/firestore.services.dart';

class AuthService {
  Future<void> googleSignUp() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(defaultAvatarURL);
      await createUserDB();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String> emailSignup(name, email, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(defaultAvatarURL);
      await createUserDB();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password'; //The password provided is too weak
      } else if (e.code == 'email-already-in-use') {
        return 'email-already-in-use'; // The account already exists for that email
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<String> emailSignin(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found'; // User with that email doesn't exist
      } else if (e.code == 'wrong-password') {
        return 'wrong-password'; // The password is invalid
      }
    }
    return '';
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

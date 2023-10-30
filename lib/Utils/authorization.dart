import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

String? uid, uemail;

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signinWithGoogle() async {
  await Firebase.initializeApp();
  User? user;
  GoogleAuthProvider authProvider = GoogleAuthProvider();
  try {
    final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);
    user = userCredential.user;
  } catch (e) {
    print(e);
  }
  if (user != null) {
    uid = user.uid;
    uemail = user.email;

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setBool('auth', true);
  }
  return user;
}

Future<User?> Signin(String email, password) async {
  try {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  catch (e) {
    debugPrint('Error during sign-in: $e');
  }
  return null;
}

Future<User?> Signup(String email, password, username) async {
  try {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  } on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
}
  catch (e) {
    debugPrint('Error during sign-up: $e');
  }
  return null;
}

Future<void> storeUserData(
    String username, email, password, confirmpass,uid) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'username': username,
    'email': email,
    'password': password,
    'confirmpass': confirmpass,
  });

  
}

Future<void> signout() async {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint('Something went wrong $e');
    }
  }

  

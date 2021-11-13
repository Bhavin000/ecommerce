import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseClass {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // getters //
  FirebaseFirestore get getFirestore => firebaseFirestore;
  FirebaseAuth get getAuth => auth;
  User? get getCurrentUser => auth.currentUser;

  // authentication //

  String get generateActionCode => (1000 + Random().nextInt(9999)).toString();

  // email operations
  Future<UserCredential> emailSignup(
    String _email,
    String _password,
  ) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    return userCredential;
  }

  Future<UserCredential> emailSignIn(
    String _email,
    String _password,
  ) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );

    return userCredential;
  }

  // google operation
  Future<UserCredential> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  // sign out
  Future<void> signOut() async => await auth.signOut();

  // firestore reference //
  CollectionReference getCollectionReference(
    String collection,
  ) {
    return firebaseFirestore.collection(collection);
  }

  DocumentReference getDocumentReference(
    String collection,
    String document,
  ) {
    return firebaseFirestore.collection(collection).doc(document);
  }

  // firebase storage reference //
  Reference getFirebaseStorageRef(
    String file,
  ) {
    return firebaseStorage.ref(file);
  }
}

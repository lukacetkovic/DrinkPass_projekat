import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  AuthState() {

    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }



 Future<void> register({
  required String email,
  required String password,
  required String displayName,
}) async {
  final cred = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  await cred.user?.updateDisplayName(displayName);

  await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
    'email': email,
    'displayName': displayName,
    'role': 'user',
    'createdAt': FieldValue.serverTimestamp(),
  });

  await cred.user?.reload();
  _user = _auth.currentUser;
  notifyListeners();
}

  Future<void> logout() async {
    await _auth.signOut();
  }
}

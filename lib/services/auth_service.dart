import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user
  Future<UserModel?> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a new UserModel instance after successful registration
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!, password: '',
      );

      // Optionally save user data to Firebase Firestore or Realtime Database
      // FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toMap());

      return user;
    } catch (e) {
      debugPrint('Error during registration: $e');
      return null; // Return null in case of failure
    }
  }

  // Sign in with email and password
  // Login method
  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw e;
    }
  }


  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the current user
  UserModel? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email!, password: '');
    }
    return null;
  }

  // Reset password functionality (sending reset link)
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Error during password reset: $e');
    }
  }
}

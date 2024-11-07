// lib/models/user_model.dart
class UserModel {
  final String uid;
  final String email;
  final String password;

  // Constructor to create a new UserModel instance
  UserModel({
    required this.uid,
    required this.email,
    required this.password,
  });

  // Factory constructor to create a UserModel from a Firebase user
  factory UserModel.fromFirebaseUser(UserModel user, String password) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      password: password, // Store password for registration
    );
  }

  // Method to convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password, // It's generally not recommended to store plain password
    };
  }

  // Method to create a UserModel from Firestore document snapshot
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
    );
  }
}

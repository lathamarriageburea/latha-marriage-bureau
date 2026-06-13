import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<void> saveProfile({
    required Map<String, dynamic> profileData,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(
          profileData,
          SetOptions(merge: true),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getProfile() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    return await _firestore
        .collection('users')
        .doc(user.uid)
        .get();
  }
}
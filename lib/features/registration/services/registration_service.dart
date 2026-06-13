import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_profile_model.dart';

class RegistrationService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadProfilePhoto({
    required String uid,
    required Uint8List photoBytes,
  }) async {
    final ref = _storage
        .ref()
        .child('profile_photos')
        .child('$uid.jpg');

    await ref.putData(photoBytes);

    return await ref.getDownloadURL();
  }

  Future<void> saveProfile(
    UserProfileModel profile,
  ) async {
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .set(profile.toMap());
  }
}
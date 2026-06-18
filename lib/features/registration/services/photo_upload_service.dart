import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class PhotoUploadService {
  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadProfilePhoto({
    required String uid,
    required Uint8List bytes,
  }) async {

    // ── Size validation (max 5MB) ──────────────────────────────
    if (bytes.lengthInBytes > 5 * 1024 * 1024) {
      throw Exception(
        'Photo size must be less than 5MB. Please choose a smaller image.',
      );
    }

    final ref = _storage
        .ref()
        .child('profile_photos')
        .child('$uid.jpg');

    await ref.putData(bytes);

    return await ref.getDownloadURL();
  }
}
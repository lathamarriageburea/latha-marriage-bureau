import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class PhotoUploadService {
  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadProfilePhoto({
    required String uid,
    required Uint8List bytes,
  }) async {
    final ref = _storage
        .ref()
        .child('profile_photos')
        .child('$uid.jpg');

    await ref.putData(bytes);

    return await ref.getDownloadURL();
  }
}
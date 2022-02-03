
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreService{

  static final _storage = FirebaseStorage.instance.ref();
  static const folder = 'post_images';

  static Future<String?> uploadImage(File _image) async {
    String img_name = 'image_' + DateTime.now().toString();
    Reference firebaseStorageRef = _storage.child(folder).child(img_name);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask.snapshot;
    if (taskSnapshot != null) {
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }
}



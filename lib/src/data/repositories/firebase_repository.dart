import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/data/models/item_model.dart';
import 'package:ecommerce/src/data/repositories/firebase_parent.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseRepo extends FirebaseParent {
  get getCurrentUserId => firebase.getCurrentUser!.uid;

  Future<bool> googleSignIn() async {
    try {
      await firebase.googleSignIn();

      await firebase.getDocumentReference('users', getCurrentUserId).set({
        'added_items': FieldValue.arrayUnion([]),
        'saved_items': FieldValue.arrayUnion([]),
      });

      // ignore: avoid_print
      print('sign in with google');

      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  void signOut() async {
    try {
      await firebase.signOut();
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  Future<bool> checkSignedIn() async {
    try {
      await firebase.getCurrentUser!.getIdToken(true);
      return true;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      return false;
    }
  }

  Future<List<ItemModel>> getAllItems() async {
    final result = await firebase.getCollectionReference('items').get();
    return result.docs.map((map) => ItemModel.fromJson(map)).toList();
  }

  addItem(ItemModel data) async {
    final ref = await firebase.getCollectionReference('items').add({
      'title': data.title,
      'description': data.description,
      'price': data.price,
      'image_url': data.imageUrl,
      'created_by': data.createdBy,
    });

    await firebase.getDocumentReference('users', getCurrentUserId).update({
      'added_items': FieldValue.arrayUnion([ref.id]),
    });
  }

  Future<String?> addImage() async {
    try {
      ImagePicker _picker = ImagePicker();
      final img = await _picker.pickImage(source: ImageSource.gallery);
      File imgFile = File(img!.path);
      final uploadedImg = await firebase
          .getFirebaseStorageRef('items/${img.name}')
          .putFile(imgFile);

      return await uploadedImg.ref.getDownloadURL();
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }
}

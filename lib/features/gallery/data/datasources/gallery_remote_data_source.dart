import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:imageGallery/features/gallery/data/models/image_gallery_model.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';

abstract class GalleryRemoteDataSource {
  Future<List<ImageGallery>> setImageGallery(
      ImageGalleryModel image, String userId, File file);

  Future<List<ImageGallery>> getUserImages(String userId);
}

class GalleryRemoteDataSourceImpl extends GalleryRemoteDataSource {
  final _collectionName = "user";
  final _subCollectionName = "myPhotos";
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  GalleryRemoteDataSourceImpl(
      {@required this.firestore, @required this.firebaseStorage});
  @override
  Future<List<ImageGallery>> setImageGallery(
      ImageGalleryModel image, String userId, File file) async {
    try {
      final fileName = userId +
          DateTime.now().millisecondsSinceEpoch.toString().replaceAll(" ", "_");

      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask storageUploadTask = firebaseStorageRef.putFile(file);
      StorageTaskSnapshot storageSnapshot = await storageUploadTask.onComplete;

      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      image.imageLink = downloadUrl;
      DocumentReference docRef = firestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_subCollectionName)
          .doc();
      docRef.set(image.toJson());
      CollectionReference collectionReference = firestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_subCollectionName);
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<DocumentSnapshot> listDoc = querySnapshot.docs;
      return ImageGalleryModel.getListFromDocumentsSnapshots(listDoc);
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print("[GalleryRemoteDataSourceImpl] ${e.toString()}");
      throw ServerException();
    }
  }

  @override
  Future<List<ImageGallery>> getUserImages(String userId) async {
    try {
      CollectionReference collectionReference = firestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_subCollectionName);
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<DocumentSnapshot> listDoc = querySnapshot.docs;
      return ImageGalleryModel.getListFromDocumentsSnapshots(listDoc);
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print("[GalleryRemoteDataSourceImpl] ${e.toString()}");
      throw ServerException();
    }
  }
}

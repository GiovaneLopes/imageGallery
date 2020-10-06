import 'package:flutter/services.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imageGallery/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp(UserModel userModel, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
      {@required this.firebaseAuth, @required this.firebaseFirestore});

  @override
  Future<String> signUp(UserModel userModel, String password) async {
    String userToken;
    bool isEmailVerified;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      await result.user.sendEmailVerification();
      DocumentReference newDoc =
          firebaseFirestore.collection("user").doc(result.user.uid);
      newDoc.set(userModel.toJson());
      userToken = await result.user.getIdToken();
      isEmailVerified = result.user.emailVerified;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print("[AuthRemoteDataSourceImpl] ${e.toString()}");
      throw ServerException();
    }

    if (userToken == null) {
      throw ServerException();
    } else if (!isEmailVerified) {
      throw EmailNotVerifiedException();
    } else {
      return userToken;
    }
  }
}

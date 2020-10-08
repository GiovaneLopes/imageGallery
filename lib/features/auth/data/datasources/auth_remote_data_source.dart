import 'package:flutter/services.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:imageGallery/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imageGallery/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp(UserModel userModel, String password);
  Future<String> signIn(String email, String password);
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<User> confirmEmailVerified();
  Future<void> recoverPassword(String email);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    @required this.firebaseAuth,
    @required this.firebaseFirestore,
  });

  @override
  Future<String> signUp(UserModel userModel, String password) async {
    String userId;
    bool isEmailVerified;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      await result.user.sendEmailVerification();
      DocumentReference newDoc =
          firebaseFirestore.collection("user").doc(result.user.uid);
      newDoc.set(userModel.toJson());
      userId = result.user.uid;
      isEmailVerified = result.user.emailVerified;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print("[AuthRemoteDataSourceImpl] ${e.toString()}");
      throw ServerException();
    }
    if (userId == null) {
      throw ServerException();
    } else {
      if (!isEmailVerified) {
        throw EmailNotVerifiedException();
      } else {
        return userId;
      }
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    return await sendRequest(makeRequest: () async {
      User user = firebaseAuth.currentUser;
      user.sendEmailVerification();
    });
  }

  @override
  Future<User> confirmEmailVerified() async {
    return await sendRequest(makeRequest: () async {
      User user = firebaseAuth.currentUser;
      user.reload();
      print(user);
      return user;
    });
  }

  @override
  Future<String> signIn(String email, String password) async {
    String userId;
    bool isEmailVerified;
    await sendRequest(makeRequest: () async {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      userId = result.user.uid;
      isEmailVerified = result.user.emailVerified;
    });
    if (userId == null) {
      throw ServerException();
    } else if (!isEmailVerified) {
      throw EmailNotVerifiedException;
    } else {
      return userId;
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    return await sendRequest(makeRequest: () async {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    });
  }

  @override
  Future<void> signOut() async {
    return await sendRequest(makeRequest: () async {
      await firebaseAuth.signOut();
    });
  }

  Future<dynamic> sendRequest({@required Function makeRequest}) async {
    try {
      return await makeRequest();
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print("[AuthRemoteDataSourceImpl] ${e.toString()}");
      throw ServerException();
    }
  }
}

import 'package:flutter/services.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/features/auth/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/core/platform/networkinfo.dart';
import 'package:imageGallery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, String>> signUp(User user, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final String tokenToSave =
            await remoteDataSource.signUp(UserModel.fromEntity(user), password);
        return Right(tokenToSave);
      } on ServerException {
        return Left(ServerFailure());
      } on PlatformException catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      } on EmailNotVerifiedException {
        return Left(EmailNotVerifiedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.sendEmailVerification());
      } on ServerException {
        return Left(ServerFailure());
      } on PlatformFailure catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> confirmEmailVerified() async {
    if (await networkInfo.isConnected) {
      try {
        var sendRequestResult = await remoteDataSource.confirmEmailVerified();
        return Right(sendRequestResult);
      } on ServerException {
        return Left(ServerFailure());
      } on PlatformException catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      } on EmailNotVerifiedException {
        return Left(EmailNotVerifiedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final String userId = await remoteDataSource.signIn(email, password);
        return Right(userId);
      } on ServerException {
        return Left(ServerFailure());
      } on PlatformException catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      } on EmailNotVerifiedException {
        return Left(EmailNotVerifiedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> recoverPassword(String email) async {
    if (await networkInfo.isConnected) {
      var result;
      var sendRequestResult = await sendRequest(makeRequest: () async {
        await remoteDataSource.recoverPassword(email);
        result = null;
      });
      return sendRequestResult.fold(
          (failure) => Left(failure), (success) => Right(result));
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await networkInfo.isConnected) {
      return await sendRequest(makeRequest: () async {
        await remoteDataSource.signOut();
      });
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  Future<Either<Failure, bool>> sendRequest(
      {@required Function makeRequest}) async {
    try {
      await makeRequest();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on EmailNotVerifiedException {
      return Left(EmailNotVerifiedFailure());
    } on PlatformException catch (e) {
      return Left(PlatformFailure(code: e.code, message: e.message));
    }
  }
}

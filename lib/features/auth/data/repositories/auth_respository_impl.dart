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
}

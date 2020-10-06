import 'package:dartz/dartz.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(User user, String password);

  Future<Either<Failure, String>> signIn(String email, String password);

  Future<Either<Failure, void>> sendEmailVerification();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> recoverPassword(String email);

  Future<Either<Failure, bool>> confirmEmailVerified();

  Future<Either<Failure, EnumUserStatus>> getUserStatus();
}

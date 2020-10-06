import 'package:dartz/dartz.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(User user, String password);
}

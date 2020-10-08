import 'package:firebase_auth/firebase_auth.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class ConfirmEmailVerified extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  ConfirmEmailVerified(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await authRepository.confirmEmailVerified();
  }
}

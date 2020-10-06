import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerification extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SendEmailVerification(this.authRepository);

  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await authRepository.sendEmailVerification();
  }
}

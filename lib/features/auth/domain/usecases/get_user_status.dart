import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class GetUserStatus extends UseCase<EnumUserStatus, NoParams> {
  final AuthRepository authRepository;

  GetUserStatus(this.authRepository);
  @override
  Future<Either<Failure, EnumUserStatus>> call(NoParams params) {
    return authRepository.getUserStatus();
  }
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class RecoverPassword extends UseCase<void, Params> {
  final AuthRepository authRepository;

  RecoverPassword(this.authRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await authRepository.recoverPassword(params.email);
  }
}

class Params extends Equatable {
  final String email;

  Params({@required this.email});

  @override
  List<Object> get props => [email];
}

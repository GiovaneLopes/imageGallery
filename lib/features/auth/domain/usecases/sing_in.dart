import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class SignIn extends UseCase<String, Params> {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await authRepository.signIn(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

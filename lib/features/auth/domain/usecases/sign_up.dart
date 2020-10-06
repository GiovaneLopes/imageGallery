import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/repositories/auth_repository.dart';

class SignUp extends UseCase<String, Params> {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await authRepository.signUp(params.user, params.password);
  }
}

class Params extends Equatable {
  final User user;
  final String password;

  Params({@required this.user, @required this.password});
  @override
  List<Object> get props => [user, password];
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';

import 'package:meta/meta.dart';
import 'package:imageGallery/features/auth/domain/usecases/sign_up.dart'
    as sign_up;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final sign_up.SignUp signUp;

  AuthBloc({@required this.signUp}) : assert(signUp != null) {
    this.add(GetUserStatusEvent());
  }

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignUpEvent) {
      yield Loading();
      var userOrError = await signUp(
          sign_up.Params(user: event.user, password: event.password));
      yield* _eitherLoadedOrErrorStateWithString(userOrError);
    }
  }

  Stream<AuthState> _eitherLoadedOrErrorStateWithString(
    Either<Failure, String> failureOrString,
  ) async* {
    yield failureOrString.fold(
      (failure) {
        if (failure is EmailNotVerifiedFailure) {
          return EmailNotVerifiedState();
        } else {
          return Error(failure: failure);
        }
      },
      (userId) => Loaded(),
    );
  }
}

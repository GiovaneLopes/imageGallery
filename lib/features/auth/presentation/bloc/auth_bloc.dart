import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';
import 'package:imageGallery/features/auth/domain/usecases/confirm_email_verified.dart';
import 'package:imageGallery/features/auth/domain/usecases/get_user_status.dart';
import 'package:imageGallery/features/auth/domain/usecases/recover_password.dart'
    as recover_password;
import 'package:imageGallery/features/auth/domain/usecases/send_email_verification.dart';
import 'package:imageGallery/features/auth/domain/usecases/sign_out.dart';
import 'package:imageGallery/features/auth/domain/usecases/sing_in.dart'
    as sign_in;

import 'package:meta/meta.dart';
import 'package:imageGallery/features/auth/domain/usecases/sign_up.dart'
    as sign_up;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final sign_up.SignUp signUp;
  final sign_in.SignIn signIn;
  final SendEmailVerification sendEmailVerification;
  final ConfirmEmailVerified confirmEmailVerified;
  final recover_password.RecoverPassword recoverPassword;
  final SignOut signOut;
  final GetUserStatus getUserStatus;

  AuthBloc({
    @required this.signUp,
    @required this.signIn,
    @required this.recoverPassword,
    @required this.sendEmailVerification,
    @required this.confirmEmailVerified,
    @required this.signOut,
    @required this.getUserStatus,
  })  : assert(signUp != null),
        assert(signIn != null),
        assert(recoverPassword != null),
        assert(sendEmailVerification != null),
        assert(confirmEmailVerified != null),
        assert(signOut != null) {
    this.add(
      GetUserStatusEvent(),
    );
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
      yield* _eitherEmailSentOrErrorStateWithString(userOrError);
    } else if (event is ResentEmailEvent) {
      yield Loading();
      var failureOrVoid = await sendEmailVerification(NoParams());
      yield* _eitherInitialOrErrorStateWithVoid(failureOrVoid);
    } else if (event is ConfirmEmailVerifiedEvent) {
      yield Loading();
      var failureOrBool = await confirmEmailVerified(NoParams());
      yield* _eitherLoadedOrErrorStateWithBool(failureOrBool);
    } else if (event is SignInEvent) {
      yield Loading();
      var failureOrString = await signIn(
          sign_in.Params(email: event.email, password: event.password));
      yield* _eitherLoadedOrErrorStateWithString(failureOrString);
    } else if (event is RecoverPasswordEvent) {
      yield Loading();
      var failureOrVoid =
          await recoverPassword(recover_password.Params(email: event.email));
      yield* _eitherRecoverSentOrErrorStateWithVoid(failureOrVoid);
    } else if (event is SignOutEvent) {
      yield Loading();
      var failureOrVoid = await signOut(NoParams());
      yield* _eitherSignedOutOrErrorStateWithVoid(failureOrVoid);
    } else if (event is GetUserStatusEvent) {
      yield Loading();
      var failureOrStatus = await getUserStatus(NoParams());
      yield* _eitherLoadedOrError(failureOrStatus);
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

  Stream<AuthState> _eitherEmailSentOrErrorStateWithString(
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
      (userId) => EmailNotVerifiedState(),
    );
  }

  Stream<AuthState> _eitherInitialOrErrorStateWithVoid(
    Either<Failure, void> failureOrVoid,
  ) async* {
    yield failureOrVoid.fold(
      (failure) {
        return Error(failure: failure);
      },
      (result) => EmailResent(),
    );
  }

  Stream<AuthState> _eitherLoadedOrErrorStateWithBool(
    Either<Failure, bool> failureOrVoid,
  ) async* {
    yield failureOrVoid.fold((failure) {
      return Error(failure: failure);
    }, (result) {
      if (result)
        return Loaded();
      else
        return AuthInitial();
    });
  }

  Stream<AuthState> _eitherRecoverSentOrErrorStateWithVoid(
    Either<Failure, void> failureOrVoid,
  ) async* {
    yield failureOrVoid.fold(
      (failure) {
        return Error(failure: failure);
      },
      (result) => RecoverPasswordEmailSent(),
    );
  }

  Stream<AuthState> _eitherSignedOutOrErrorStateWithVoid(
    Either<Failure, void> failureOrVoid,
  ) async* {
    yield failureOrVoid.fold(
      (failure) {
        return Error(failure: failure);
      },
      (result) => SignedOut(),
    );
  }

  Stream<AuthState> _eitherLoadedOrError(
    Either<Failure, EnumUserStatus> failureOrStatus,
  ) async* {
    yield failureOrStatus.fold((failure) {
      return Error(failure: failure);
    }, (status) {
      if (status == EnumUserStatus.IsntLoggedIn) {
        return UserNotLoggedIn();
      } else if (status == EnumUserStatus.IsLoggedIn) {
        return Logged();
      } else {
        return Error(failure: ServerFailure());
      }
    });
  }
}

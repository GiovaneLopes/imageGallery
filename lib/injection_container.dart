import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:imageGallery/core/platform/networkinfo.dart';
import 'package:imageGallery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:imageGallery/features/auth/domain/usecases/confirm_email_verified.dart';
import 'package:imageGallery/features/auth/domain/usecases/recover_password.dart';
import 'package:imageGallery/features/auth/domain/usecases/send_email_verification.dart';
import 'package:imageGallery/features/auth/domain/usecases/sign_out.dart';
import 'package:imageGallery/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/repositories/auth_respository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/domain/usecases/sing_in.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!Features
  _initAuth();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void _initAuth() {
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      signUp: sl(),
      signIn: sl(),
      recoverPassword: sl(),
      sendEmailVerification: sl(),
      confirmEmailVerified: sl(),
      signOut: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => RecoverPassword(sl()));
  sl.registerLazySingleton(() => SendEmailVerification(sl()));
  sl.registerLazySingleton(() => ConfirmEmailVerified(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );
}

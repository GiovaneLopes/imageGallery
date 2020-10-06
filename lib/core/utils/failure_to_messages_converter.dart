import 'package:flutter/material.dart';
import 'package:imageGallery/core/error/failure.dart';

class FailureToMessagesConverter {
  String convert(BuildContext context, Failure failure) {
    if (failure is PlatformFailure)
      return failure.message;
    else if (failure is ServerFailure)
      return "Ocorreu um erro no servidor";
    else if (failure is NoInternetConnectionFailure)
      return "Você não possui conexão com a internet";
    else if (failure is CacheFailure)
      return "Tivemos problemas ao recuperar seus dados";
    else
      return "Ocorreu um erro inesperado.";
  }
}

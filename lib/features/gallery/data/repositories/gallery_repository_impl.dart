import 'package:flutter/services.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/platform/networkinfo.dart';
import 'package:imageGallery/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:imageGallery/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:imageGallery/features/gallery/data/models/image_gallery_model.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';
import 'package:imageGallery/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource galleryRemoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GalleryRepositoryImpl(
      {@required this.galleryRemoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, List<ImageGallery>>> setImageGallery(
      ImageGallery image, File file) async {
    String userId;
    List<ImageGalleryModel> result;
    if (await networkInfo.isConnected) {
      try {
        userId = await localDataSource.getUserToken();
      } on PlatformException catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
    if (userId == null) {
      return Left(ServerFailure());
    } else {
      result = await galleryRemoteDataSource.setImageGallery(
          ImageGalleryModel.fromEntity(image), userId, file);
      return Right(result);
    }
  }

  @override
  Future<Either<Failure, List<ImageGallery>>> getUserImages() async {
    if (await networkInfo.isConnected) {
      String userId;
      try {
        userId = await localDataSource.getUserToken();
        List<ImageGallery> result =
            await galleryRemoteDataSource.getUserImages(userId);
        return Right(result);
      } on PlatformException catch (e) {
        return Left(PlatformFailure(code: e.code, message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}

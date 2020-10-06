import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<ImageGallery>>> setImageGallery(
      ImageGallery image, File file);

  Future<Either<Failure, List<ImageGallery>>> getUserImages();
}

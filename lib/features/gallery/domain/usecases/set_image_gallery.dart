import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';

class SetImageGallery extends UseCase<List<ImageGallery>, Params> {
  final GalleryRepository galleryRepository;

  SetImageGallery(this.galleryRepository);
  @override
  Future<Either<Failure, List<ImageGallery>>> call(Params params) async {
    return await galleryRepository.setImageGallery(params.image, params.file);
  }
}

class Params extends Equatable {
  final ImageGallery image;
  final File file;

  Params(this.image, this.file);

  @override
  List<Object> get props => [image, file];
}

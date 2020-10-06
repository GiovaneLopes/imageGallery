import 'package:imageGallery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';
import 'package:imageGallery/features/gallery/domain/repositories/gallery_repository.dart';

class GetUserImages implements UseCase<List<ImageGallery>, NoParams> {
  final GalleryRepository galleryRepository;

  GetUserImages(this.galleryRepository);
  @override
  Future<Either<Failure, List<ImageGallery>>> call(NoParams noParams) async {
    return await galleryRepository.getUserImages();
  }
}

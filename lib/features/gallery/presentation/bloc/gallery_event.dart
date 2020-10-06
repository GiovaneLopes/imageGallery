part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class GetImagesGalleryEvent extends GalleryEvent {}

class SetImageGalleryEvent extends GalleryEvent {
  final ImageGallery imageGallery;
  final File file;
  SetImageGalleryEvent({@required this.imageGallery, @required this.file});

  @override
  List<Object> get props => [imageGallery, file];
}

part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
  @override
  List<Object> get props => [];
}

class Empty extends GalleryState {}

class Loading extends GalleryState {}

class Loaded extends GalleryState {
  final List<ImageGallery> images;

  Loaded(this.images);

  @override
  List<Object> get props => [images];
}

class Error extends GalleryState {
  final Failure failure;

  Error({@required this.failure});

  @override
  List<Object> get props => [failure];
}

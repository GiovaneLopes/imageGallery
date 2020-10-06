import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imageGallery/core/usecases/usecase.dart';
import 'package:imageGallery/features/gallery/domain/usecases/get_user_images.dart';
import 'dart:io';
import 'package:imageGallery/features/gallery/domain/usecases/set_image_gallery.dart';
import 'package:meta/meta.dart';
import 'package:imageGallery/core/error/failure.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final SetImageGallery setImageGallery;
  final GetUserImages getUserImages;

  GalleryBloc({@required this.setImageGallery, @required this.getUserImages})
      : assert(setImageGallery != null),
        assert(getUserImages != null) {
    this.add(GetImagesGalleryEvent());
  }

  @override
  GalleryState get initialState => Empty();

  @override
  Stream<GalleryState> mapEventToState(
    GalleryEvent event,
  ) async* {
    if (event is SetImageGalleryEvent) {
      yield Loading();
      var failureOrImagesList = await setImageGallery(
        Params(event.imageGallery, event.file),
      );
      yield* _eitherLoadedOrErrorState(failureOrImagesList);
    } else if (event is GetImagesGalleryEvent) {
      yield Loading();
      var failureOrImagesList = await getUserImages(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrImagesList);
    }
  }

  Stream<GalleryState> _eitherLoadedOrErrorState(
    Either<Failure, List<ImageGallery>> failureOrImage,
  ) async* {
    yield failureOrImage.fold(
      (failure) {
        return Error(failure: failure);
      },
      (images) => Loaded(images),
    );
  }
}

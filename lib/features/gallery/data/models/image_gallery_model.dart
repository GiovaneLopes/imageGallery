import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';
import 'package:meta/meta.dart';

class ImageGalleryModel extends ImageGallery {
  ImageGalleryModel({id, @required name, @required imageLink, @required order})
      : super(id: id, name: name, imageLink: imageLink, order: order);

  factory ImageGalleryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ImageGalleryModel(
      id: json["id"],
      name: json["name"],
      imageLink: json["imageLink"],
      order: json["order"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;
    if (imageLink != null) json['imageLink'] = imageLink;
    if (order != null) json['order'] = order;

    return json;
  }

  factory ImageGalleryModel.fromEntity(ImageGallery imageGallery) {
    if (imageGallery == null) return null;

    return ImageGalleryModel(
      id: imageGallery.id,
      name: imageGallery.name,
      imageLink: imageGallery.imageLink,
      order: imageGallery.order,
    );
  }

  factory ImageGalleryModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) return null;

    Map<String, dynamic> jsonMap = documentSnapshot.data();
    jsonMap['id'] = documentSnapshot.id;

    return ImageGalleryModel.fromJson(jsonMap);
  }

  static List<ImageGalleryModel> getListFromDocumentsSnapshots(
      List<DocumentSnapshot> listDocs) {
    if (listDocs == null) return null;

    return listDocs.map((documentSnapshot) {
      return ImageGalleryModel.fromDocumentSnapshot(documentSnapshot);
    }).toList();
  }
}

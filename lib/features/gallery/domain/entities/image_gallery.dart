import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ImageGallery extends Equatable {
  final String id;
  String imageLink;
  String name;
  int order;

  ImageGallery(
      {this.id,
      @required this.imageLink,
      @required this.name,
      @required this.order,});

  @override
  List<Object> get props => [
        id,
        imageLink,
        name,
        order,
      ];
}

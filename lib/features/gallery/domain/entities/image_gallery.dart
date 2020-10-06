import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ImageGallery extends Equatable {
  final String id;
  String imageLink;
  String name;
  String discription;
  String time;

  ImageGallery(
      {this.id,
      @required this.imageLink,
      @required this.name,
      @required this.discription,
      @required this.time});

  @override
  List<Object> get props => [
        id,
        imageLink,
        name,
        discription,
        time,
      ];
}

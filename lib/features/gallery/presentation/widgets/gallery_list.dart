import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';

import 'no_images_widget.dart';

class GalleryList extends StatelessWidget {
  final List<ImageGallery> images;

  const GalleryList({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (images == null || images.isEmpty)
        //Empty image list
        ? NoImagesWidget()
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Dimensions.getConvertedHeightSize(context, 30),
                ),
                Column(
                  // List images list
                  children: images.map((data) {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              (data.imageLink == null) ? "" : data.imageLink,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          padding: Dimensions.getEdgeInsets(context,
                              top: 15, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Image name
                              Text(
                                (data.name == null) ? "" : data.name,
                                style: TextStyle(
                                  fontSize: Dimensions.getTextSize(context, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Image date
                              Text(
                                (data.time == null) ? "" : data.time.toString(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              Dimensions.getEdgeInsets(context, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                // Image discription
                                child: Text(
                                  (data.discription == null)
                                      ? ""
                                      : data.discription,
                                  style: TextStyle(
                                    fontSize:
                                        Dimensions.getTextSize(context, 14),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/features/gallery/presentation/models/image_gallery.dart';

class GalleryGrid extends StatelessWidget {
  final List<ImageGallery> images;

  const GalleryGrid({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (images == null || images.isEmpty)
        //Empty image list
        ? Image.asset(
            Images.emptyGallery,
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Dimensions.getConvertedHeightSize(context, 30),
                ),
                // Images grid wrap
                Wrap(
                  spacing: Dimensions.getConvertedWidthSize(context, 10),
                  runSpacing: Dimensions.getConvertedHeightSize(context, 10),
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  // Images grid list
                  children: images.map((data) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              data.imageLink,
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(
                          Dimensions.getConvertedWidthSize(
                            context,
                            5,
                          ),
                        ),
                      ),
                      width: Dimensions.getConvertedWidthSize(context, 145),
                      height: Dimensions.getConvertedHeightSize(context, 145),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
  }
}

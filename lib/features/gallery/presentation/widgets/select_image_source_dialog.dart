import 'dart:io';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/new_photo_dialog.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageSourceDialog extends StatefulWidget {
  @override
  _SelectImageSourceDialogState createState() =>
      _SelectImageSourceDialogState();
}

class _SelectImageSourceDialogState extends State<SelectImageSourceDialog> {
  // Image picker
  Future _imageSource(bool fromCamera) async {
    File selectedImage;
    File _image;
    if (fromCamera) {
      selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = selectedImage;
    });
    if (_image != null) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          // Add new pictture Dialog
          return NewPhotoDialog(image: _image);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: Dimensions.getEdgeInsetsAll(context, 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.getConvertedWidthSize(context, 15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // New picture dialog title
                  Text(
                    Strings(context).chooseImageSource,
                    style: TextStyle(
                      fontSize: Dimensions.getTextSize(context, 20),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  // Close dialog icon
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FeatherIcons.x,
                      size: Dimensions.getConvertedWidthSize(context, 18),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: Dimensions.getConvertedHeightSize(context, 25),
                  ),
                  InkWell(
                    onTap: () {
                      // Camera image source
                      _imageSource(true);
                    },
                    child: Row(
                      children: <Widget>[
                        // Camera icon
                        Image.asset(
                          Images.cameraIcon,
                          width: Dimensions.getConvertedWidthSize(context, 35),
                        ),
                        SizedBox(
                          width: Dimensions.getConvertedWidthSize(context, 14),
                        ),
                        // Camera title
                        Text(
                          Strings(context).cameraTitle,
                          style: TextStyle(
                            fontSize: Dimensions.getTextSize(context, 18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getConvertedHeightSize(context, 25),
                  ),
                  InkWell(
                    onTap: () {
                      // Gallery image source
                      _imageSource(false);
                    },
                    child: Row(
                      children: <Widget>[
                        // Gallery icon
                        Image.asset(
                          Images.galleryIcon,
                          width: Dimensions.getConvertedWidthSize(context, 35),
                        ),
                        SizedBox(
                          width: Dimensions.getConvertedWidthSize(context, 14),
                        ),
                        // Gallery icon
                        Text(
                          Strings(context).galleryTitle,
                          style: TextStyle(
                            fontSize: Dimensions.getTextSize(context, 18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

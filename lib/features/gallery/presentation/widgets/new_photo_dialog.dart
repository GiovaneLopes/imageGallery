import 'dart:io';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/custom_text_form_field.dart';

class NewPhotoDialog extends StatefulWidget {
  final File image;

  const NewPhotoDialog({Key key, this.image}) : super(key: key);
  @override
  _NewPhotoDialogState createState() => _NewPhotoDialogState();
}

class _NewPhotoDialogState extends State<NewPhotoDialog> {
  final Map<String, dynamic> _formData = Map<String, dynamic>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _discriptionController;

  @override
  void initState() {
    _nameController = TextEditingController(text: _formData[Keys.LABEL_EMAIL]);
    _discriptionController =
        TextEditingController(text: _formData[Keys.LABEL_PASSWORD]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: Dimensions.getEdgeInsetsAll(context, 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.getConvertedWidthSize(context, 15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // New picture dialog title
                  Text(
                    Strings.new_picture_title,
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
              // New picture image
              Container(
                margin: Dimensions.getEdgeInsets(context, top: 15),
                width: double.infinity,
                child: Image.file(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Dimensions.getConvertedHeightSize(context, 15),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // New picture name field
                    CustomTextFormField(
                      text: Strings.name_title,
                      textEditingController: _nameController,
                      isRequired: true,
                      onChanged: (String value) {
                        _formData[Keys.LABEL_PHOTO_NAME] = value;
                      },
                    ),
                    SizedBox(
                      height: Dimensions.getConvertedHeightSize(context, 20),
                    ),
                    // New picture discription field
                    CustomTextFormField(
                      text: Strings.discription_title,
                      textEditingController: _discriptionController,
                      isRequired: true,
                      onChanged: (String value) {
                        _formData[Keys.LABEL_DISCRIPTION] = value;
                      },
                    ),
                    SizedBox(
                      height: Dimensions.getConvertedHeightSize(context, 15),
                    ),
                    // Save new picture
                    ButtonApp(
                      title: Strings.save_title,
                      onPressed: () {},
                      type: ButtonType.BUTTON_BLACK,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

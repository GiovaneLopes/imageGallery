import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/strings.dart';

import 'base_input_validator.dart';

class EmailInputValidator extends BaseInputValidator {
  @override
  String validate(BuildContext context, String value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return Strings(context).emailInputMessage;
      }
    }

    return null;
  }
}

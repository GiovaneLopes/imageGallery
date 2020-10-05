import 'package:flutter/widgets.dart';
import 'base_input_validator.dart';

class EmptyInputValidator extends BaseInputValidator {
  @override
  String validate(BuildContext context, String value) {
    if (value == null || value.isEmpty)
      return "Campo vazio";

    return null;
  }
}

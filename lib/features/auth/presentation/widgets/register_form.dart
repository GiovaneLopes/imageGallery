import 'package:flutter/material.dart';
import 'package:imageGallery/core/input_validators/compare_values_input_validator.dart';
import 'package:imageGallery/core/input_validators/email_input_validator.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/custom_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final Map<String, dynamic> _formData = Map<String, dynamic>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _passwordController;
  TextEditingController _repeatPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: _formData[Keys.LABEL_EMAIL]);
    _passwordController =
        TextEditingController(text: _formData[Keys.LABEL_PASSWORD]);
    super.initState();
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: Dimensions.getEdgeInsets(context, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Register name field
            CustomTextFormField(
              text: Strings(context).nameTitle,
              textEditingController: _nameController,
              isRequired: true,
              onChanged: (String value) {
                _formData[Keys.LABEL_NAME] = value;
              },
            ),
            SizedBox(
              height: Dimensions.getConvertedHeightSize(context, 5),
            ),
            // Register email field
            CustomTextFormField(
              text: Strings(context).emailTitle,
              textEditingController: _emailController,
              isRequired: true,
              onChanged: (String value) {
                _formData[Keys.LABEL_EMAIL] = value.trim();
              },
              validator: EmailInputValidator(),
            ),
            SizedBox(
              height: Dimensions.getConvertedHeightSize(context, 5),
            ),
            // Register password field
            CustomTextFormField(
              text: Strings(context).passwordTitle,
              textEditingController: _passwordController,
              isRequired: true,
              obscureText: true,
              onChanged: (String value) {
                _formData[Keys.LABEL_PASSWORD] = value;
              },
            ),
            SizedBox(
              height: Dimensions.getConvertedHeightSize(context, 5),
            ),
            // Register repeat password field
            CustomTextFormField(
              text: Strings(context).repeatPassword,
              textEditingController: _repeatPasswordController,
              isRequired: true,
              obscureText: true,
              onChanged: (String value) {
                _formData[Keys.LABEL_REPEATPASSWORD] = value;
              },
              validator: CompareValuesInputValidator(
                errorMessage: Strings(context).doubleFormatErrorMessage,
                valueToCompare: _formData[Keys.LABEL_PASSWORD],
              ),
            ),
            SizedBox(
              height: Dimensions.getConvertedHeightSize(context, 15),
            ),
            // Register button
            ButtonApp(
              title: Strings(context).registerTitle,
              onPressed: () {
                _submitForm(context);
              },
              type: ButtonType.BUTTON_BLACK,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }
}

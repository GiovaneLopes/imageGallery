import 'package:flutter/material.dart';
import 'package:imageGallery/core/input_validators/email_input_validator.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/custom_text_form_field.dart';
import 'package:imageGallery/features/auth/presentation/widgets/recover_password_form.dart';

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final Map<String, dynamic> _formData = Map<String, dynamic>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: _formData[Keys.LABEL_EMAIL]);
    _passwordController =
        TextEditingController(text: _formData[Keys.LABEL_PASSWORD]);
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: Dimensions.getEdgeInsets(context, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Sign in email field
            Column(
              children: <Widget>[
                CustomTextFormField(
                  text: Strings.email_title,
                  textEditingController: _emailController,
                  isRequired: true,
                  onChanged: (String value) {
                    _formData[Keys.LABEL_EMAIL] = value.trim();
                  },
                  validator: EmailInputValidator(),
                ),
                // Sign in password field
                Padding(
                  padding: Dimensions.getEdgeInsets(context, top: 15),
                  child: CustomTextFormField(
                    text: Strings.password_title,
                    textEditingController: _passwordController,
                    obscureText: true,
                    suffixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    isRequired: true,
                    onChanged: (String value) {
                      _formData[Keys.LABEL_PASSWORD] = value;
                    },
                  ),
                ),
              ],
            ),
            // Forgot password
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return RecoverPasswordForm();
                  },
                );
              },
              child: Container(
                padding: Dimensions.getEdgeInsets(context, bottom: 37, top: 11),
                child: Text(
                  Strings.forgot_password,
                  style: TextStyle(
                    fontSize: Dimensions.getTextSize(context, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Sign in button
            ButtonApp(
              title: Strings.signin_title,
              onPressed: () {
                _submitForm(context);
              },
              type: ButtonType.BUTTON_BLACK,
            )
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
    return _buildBody(context);
  }
}

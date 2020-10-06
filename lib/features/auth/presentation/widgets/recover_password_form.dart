import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageGallery/core/input_validators/email_input_validator.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/custom_text_form_field.dart';
import 'package:imageGallery/features/auth/presentation/bloc/auth_bloc.dart';

class RecoverPasswordForm extends StatefulWidget {
  @override
  _RecoverPasswordFormState createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm> {
  final Map<String, dynamic> _formData = Map<String, dynamic>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController(text: _formData[Keys.LABEL_EMAIL]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Dimensions.getEdgeInsetsAll(context, 22),
        height: Dimensions.getConvertedHeightSize(context, 218),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.getConvertedWidthSize(context, 15),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Strings(context).recoverPassword,
                  style: TextStyle(
                    fontSize: Dimensions.getTextSize(context, 24),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FeatherIcons.x,
                    size: Dimensions.getConvertedWidthSize(context, 24),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextFormField(
                      text: Strings(context).emailTitle,
                      textEditingController: _emailController,
                      isRequired: true,
                      onChanged: (String value) {
                        _formData[Keys.LABEL_EMAIL] = value.trim();
                      },
                      validator: EmailInputValidator(),
                    ),
                  ],
                ),
              ),
            ),
            ButtonApp(
              title: Strings(context).sendTitle,
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

    BlocProvider.of<AuthBloc>(context)
        .add(RecoverPasswordEvent(email: _formData[Keys.LABEL_EMAIL]));

    Navigator.pop(context);
  }
}

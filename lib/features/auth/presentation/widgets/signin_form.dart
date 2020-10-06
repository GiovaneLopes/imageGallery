import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageGallery/core/input_validators/email_input_validator.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/custom_text_form_field.dart';
import 'package:imageGallery/core/ui/loading_widget.dart';
import 'package:imageGallery/core/utils/failure_to_messages_converter.dart';
import 'package:imageGallery/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:imageGallery/features/auth/presentation/pages/verify_email_page.dart';
import 'package:imageGallery/features/auth/presentation/widgets/recover_password_form.dart';
import 'package:imageGallery/features/gallery/presentation/bloc/gallery_bloc.dart'
    as _galleryBloc;

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
                  text: Strings(context).emailTitle,
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
                    text: Strings(context).passwordTitle,
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
                  Strings(context).forgotPassword,
                  style: TextStyle(
                    fontSize: Dimensions.getTextSize(context, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Sign in button
            ButtonApp(
              title: Strings(context).signinTitle,
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
    BlocProvider.of<AuthBloc>(context).add(
      SignInEvent(
        email: _formData[Keys.LABEL_EMAIL],
        password: _formData[Keys.LABEL_PASSWORD],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                FailureToMessagesConverter().convert(context, state.failure),
              ),
            ),
          );
        } else if (state is Loaded) {
          BlocProvider.of<_galleryBloc.GalleryBloc>(context)
              .add(_galleryBloc.GetImagesGalleryEvent());
          Navigator.of(context).pushReplacementNamed('/galleryScreen');
        } else if (state is EmailNotVerifiedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return VerifyEmailPage();
              },
            ),
          );
        } else if (state is RecoverPasswordState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                Strings(context).recoverPassword,
              ),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Loading) {
          return LoadingWidget(_buildBody(context));
        } else {
          return _buildBody(context);
        }
      }),
    );
  }
}

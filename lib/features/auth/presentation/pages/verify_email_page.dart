import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';
import 'package:imageGallery/core/ui/loading_widget.dart';
import 'package:imageGallery/core/utils/failure_to_messages_converter.dart';
import 'package:imageGallery/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:imageGallery/features/gallery/presentation/bloc/gallery_bloc.dart'
    as _galleryBloc;

class VerifyEmailPage extends StatelessWidget {
  Widget _buildBody(BuildContext context) {
    return Container(
      padding: Dimensions.getEdgeInsetsFromLTRB(context, 37, 83, 37, 55),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // App name
          Text(
            Strings(context).appName,
            style: TextStyle(
              fontSize: Dimensions.getTextSize(context, 28),
            ),
          ),
          // Verify email image
          Padding(
            padding: Dimensions.getEdgeInsets(context, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.mail,
                  size: Dimensions.getConvertedWidthSize(context, 50),
                ),
                SizedBox(
                  height: Dimensions.getConvertedHeightSize(context, 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        Strings(context).emailVerificationText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Dimensions.getTextSize(context, 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              // Email verified button
              ButtonApp(
                title: Strings(context).emailVerified,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(ConfirmEmailVerifiedEvent());
                },
                type: ButtonType.BUTTON_BLACK,
              ),
              // Email email button
              ButtonApp(
                title: Strings(context).resendTitle,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(ResentEmailEvent());
                },
                type: ButtonType.BUTTON_WHITE,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSendEmailDialog() {
    return Dialog(
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double scale, Widget widget) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: Dimensions.getEdgeInsetsAll(context, 22),
              height: Dimensions.getConvertedHeightSize(context, 218),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.getConvertedWidthSize(context, 15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: Dimensions.getConvertedWidthSize(context, 128),
                        child:
                            // Email sent dialog title
                            Text(
                          Strings(context).emailSentSuccessfully,
                          style: TextStyle(
                            fontSize: Dimensions.getTextSize(context, 18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      // Close dialog icon
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
                  // Ok dialog button
                  ButtonApp(
                    title: Strings(context).okTitle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    type: ButtonType.BUTTON_BLACK,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
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
          Navigator.pushNamed(context, "/galleryScreen");
        } else if (state is EmailResent) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return _buildSendEmailDialog();
            },
          );
        }
      }, child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget(_buildBody(context));
          } else {
            return _buildBody(context);
          }
        },
      )),
    );
  }
}

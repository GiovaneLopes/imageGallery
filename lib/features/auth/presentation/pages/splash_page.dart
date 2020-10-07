import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/core/ui/loading_widget.dart';
import 'package:imageGallery/features/auth/presentation/bloc/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Error) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.toString()),
                ),
              );
            } else if (state is UserNotLoggedIn) {
              Navigator.pushNamed(context, '/authPage');
            } else if (state is Logged) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/galleryScreen", (r) => false);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return LoadingWidget(_buidSplashScreen(context));
              } else {
                return _buidSplashScreen(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buidSplashScreen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/authPage');
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              Images.logo,
              width: Dimensions.getConvertedWidthSize(
                context,
                200,
              ),
            ),
            Text(
              "Image Gallery",
              style: TextStyle(
                fontSize: Dimensions.getTextSize(context, 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

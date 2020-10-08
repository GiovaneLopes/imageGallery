import 'package:flutter/widgets.dart';
import 'package:internationalization/internationalization.dart' as intl;

class Strings {
  final BuildContext context;
  // Masks
  static const String dateMask = "xx/xx/xxxx";

  // Failure To Message
  String messageServerFailure;
  String messageNoInternetFailure;
  String messageCacheFailure;
  String messageUnknownError;

  // Input validations
  String emptyInputMessage;
  String emailInputMessage;
  String doubleFormatErrorMessage;

  // Auth page
  String signinTitle;
  String registerTitle;
  String emailVerified;
  String emailSentSuccessfully;
  String resendTitle;
  String okTitle;
  String nameTitle;
  String emailTitle;
  String passwordTitle;
  String repeatPassword;
  String recoverPassword;
  String sendTitle;
  String forgotPassword;
  String appName;
  String emailVerificationText;

  //Gallery screen
  String newPictureTitle;
  String signoutTitle;
  String signoutConfirmationText;
  String cancelTitle;
  String yes;
  String discriptionTitle;
  String saveTitle;
  String cameraTitle;
  String galleryTitle;
  String chooseImageSource;
  String noImage;

  Strings(this.context) {
    // Failure To Message
    messageServerFailure =
        intl.Strings.of(context).valueOf("message_server_failure");
    messageNoInternetFailure =
        intl.Strings.of(context).valueOf("message_no_internet_failure");
    messageCacheFailure =
        intl.Strings.of(context).valueOf("message_cache_failure");
    messageUnknownError =
        intl.Strings.of(context).valueOf("message_unknown_error");
    // Validation empty message
    emptyInputMessage = intl.Strings.of(context).valueOf("empty_input_message");
    // Invalid email message
    emailInputMessage = intl.Strings.of(context).valueOf("email_input_message");

    // Auth page
    signinTitle = intl.Strings.of(context).valueOf("signin_title");
    registerTitle = intl.Strings.of(context).valueOf("register_title");
    doubleFormatErrorMessage =
        intl.Strings.of(context).valueOf("double_format_error_message");
    //Gallery screen
    newPictureTitle = intl.Strings.of(context).valueOf("new_picture_title");
    signoutTitle = intl.Strings.of(context).valueOf("signout_title");
    signoutConfirmationText =
        intl.Strings.of(context).valueOf("signout_confirmation_text");
    cancelTitle = intl.Strings.of(context).valueOf("cancel_title");
    yes = intl.Strings.of(context).valueOf("yes");
    discriptionTitle = intl.Strings.of(context).valueOf("discription_title");
    saveTitle = intl.Strings.of(context).valueOf("save_title");
    cameraTitle = intl.Strings.of(context).valueOf("camera_title");
    galleryTitle = intl.Strings.of(context).valueOf("gallery_title");
    chooseImageSource = intl.Strings.of(context).valueOf("choose_image_source");
    noImage = intl.Strings.of(context).valueOf("no_image_text");
    // Verify email page
    emailVerified = intl.Strings.of(context).valueOf("email_verified");
    emailSentSuccessfully =
        intl.Strings.of(context).valueOf("email_sent_successfully");
    resendTitle = intl.Strings.of(context).valueOf("resend_title");
    okTitle = intl.Strings.of(context).valueOf("ok_title");
    emailVerificationText =
        intl.Strings.of(context).valueOf("email_verification_text");
    //Register Form
    nameTitle = intl.Strings.of(context).valueOf("name_title");
    emailTitle = intl.Strings.of(context).valueOf("email_title");
    passwordTitle = intl.Strings.of(context).valueOf("password_title");
    repeatPassword = intl.Strings.of(context).valueOf("repeat_password");
    //Login Form
    recoverPassword = intl.Strings.of(context).valueOf("recover_password");
    sendTitle = intl.Strings.of(context).valueOf("send_title");
    forgotPassword = intl.Strings.of(context).valueOf("forgot_password");
    appName = intl.Strings.of(context).valueOf("app_name");
  }
}

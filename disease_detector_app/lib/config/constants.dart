import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

double kDefaultPadding = 25.0.w;
double kDefaultBorderRaduis = 20.0.w;

List<String> bottomPageKeys = ['/', '/', '/', '/account'];

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0.sp,
  );
}

final appPadding = EdgeInsets.symmetric(horizontal: 8.w);

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 60.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppColor.primary,
            ),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page.";
    case "account-exists-with-different-credential":
      return "Email already used. Go to login page.";
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password ";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled.";
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account.";
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account.";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid.";
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("All Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

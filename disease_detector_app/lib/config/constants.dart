import 'package:disease_detector_app/config/themes/color.dart';
// import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

double kDefaultPadding = 25.0.w;
double kDefaultBorderRaduis = 20.0.w;

List<String> bottomPageKeys = ['/', '/', '/', '/account'];

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColor.error,
    textColor: AppColor.onError,
    fontSize: 16.0.sp,
  );
}

final appPadding = EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);

showLoaderDialog(BuildContext context) {
  final alert = Center(
    child: Container(
      color: Colors.black,
      padding: const EdgeInsets.all(4),
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: 2.w,
        color: AppColor.primary,
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showMessageDialog(BuildContext context, String msg) {
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    insetAnimationDuration: const Duration(microseconds: 50),
    title: Text(
      msg,
    ),
    actions: [
      TextButton(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent)),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text(
          'Close',
          style: TextStyle(
            color: AppColor.error,
          ),
        ),
      ),
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showErrorMsg(BuildContext context, String msg) {
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Center(
      child: Text(msg),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Close"),
      ),
    ],
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

bool signUpVaildation(String email, String password, String confirmPassword) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("All Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else if (confirmPassword.isEmpty) {
    showMessage("Please Confirm Password");
    return false;
  } else if (password != confirmPassword) {
    showMessage("Confirm Password is not Correct");
    return false;
  } else {
    return true;
  }
}

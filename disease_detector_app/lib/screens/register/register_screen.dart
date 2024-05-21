import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/app_size.dart';
import '../../config/themes/color.dart';
import '../../utils/custom_text_theme/custom_text_theme.dart';
import '../../utils/helper/helper_function.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController editingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: AppSize.appbarHeight,
          ),
          SizedBox(
            height: AppSize.lg,
          ),
          Text(
            "WELCOME",
            style: dark
                ? MyTextTheme.darkTextTheme.headlineLarge
                : MyTextTheme.lightTextTheme.headlineLarge,
          ),
          SizedBox(
            height: AppSize.lg,
          ),
          MyTextFormField(
              dark: dark,
              hint: "Enter your Email",
              controller: editingController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next),
          SizedBox(
            height: AppSize.lg,
          ),
          MyTextFormField(
              dark: dark,
              hint: "Enter Password",
              controller: passwordController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next),
          SizedBox(
            height: AppSize.xl,
          ),
          MyTextFormField(
              dark: dark,
              hint: "Confirm Password",
              controller: confirmController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.done),
          SizedBox(
            height: AppSize.xl,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              child: MyButton(dark: dark, name: "Sign Up")),
          SizedBox(
            height: AppSize.xl,
          ),
          SizedBox(
            height: AppSize.md,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: dark
                    ? MyTextTheme.darkTextTheme.titleMedium
                    : MyTextTheme.lightTextTheme.titleMedium,
              ),
              SizedBox(
                width: AppSize.xs,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                  ))
            ],
          )
        ],
      )),
    );
  }
}

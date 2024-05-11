
import 'package:flutter/material.dart';

import '../../constanst/app_color.dart';
import '../../constanst/app_size.dart';
import '../../utils/helper/helper_function.dart';
import '../../utils/theme/custom_text_theme/custom_text_theme.dart';
import '../../widget/my_button.dart';
import '../../widget/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController editingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.appbarHeight,
            ),
            SizedBox(
              height: AppSize.lg,
            ),
            Text(
              "LOGIN",
              style: dark
                  ? MyTextTheme.darkTextTheme.headlineLarge
                  : MyTextTheme.lightTextTheme.headlineLarge,
            ),
            SizedBox(
              height: AppSize.xl,
            ),
            MyTextFormField(
                dark: dark,
                hint: "Username or Email",
                controller: editingController,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next),
            SizedBox(
              height: AppSize.xl,
            ),
            MyTextFormField(
                dark: dark,
                hint: "Password",
                controller: passwordController,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next),
            SizedBox(
              height: AppSize.sm,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: dark
                    ? MyTextTheme.darkTextTheme.titleMedium
                    : MyTextTheme.lightTextTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: AppSize.xl,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: MyButton(dark: dark, name: "Login")),
            SizedBox(
              height: AppSize.lg,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?",
                  style: dark
                      ? MyTextTheme.darkTextTheme.titleMedium
                      : MyTextTheme.lightTextTheme.titleMedium,
                ),
                SizedBox(
                  width: AppSize.xs,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

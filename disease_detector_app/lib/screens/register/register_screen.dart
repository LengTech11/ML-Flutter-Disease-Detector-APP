import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants.dart';
import '../../config/themes/app_size.dart';
import '../../config/themes/color.dart';
import '../../firebase_helpers/firebase_auth/firebase_auth_helpers.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      // key: _formKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
              hint: "Enter your First Name",
              controller: firstNameController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
            SizedBox(
              height: AppSize.lg,
            ),
            MyTextFormField(
              dark: dark,
              hint: "Enter your Last Name",
              controller: lastNameController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
            SizedBox(
              height: AppSize.lg,
            ),
            MyTextFormField(
              dark: dark,
              hint: "Enter your Email",
              controller: editingController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
            SizedBox(
              height: AppSize.lg,
            ),
            MyTextFormField(
              dark: dark,
              hint: "Enter Password",
              controller: passwordController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
            SizedBox(
              height: AppSize.xl,
            ),
            MyTextFormField(
              dark: dark,
              hint: "Confirm Password",
              controller: confirmController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              visible: false,
            ),
            SizedBox(
              height: AppSize.xl,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: MyButton(
                    dark: dark,
                    name: "Sign Up",
                    onPress: () async {
                      String name =
                          "${firstNameController.text} ${lastNameController.text}";
                      bool isValidated = signUpVaildation(
                          editingController.text, passwordController.text);
                      if (isValidated) {
                        bool isLogined = await FirebaseAuthHelper.instance
                            .signUp(name, editingController.text,
                                passwordController.text, context);
                        if (isLogined) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        }
                      }
                    })),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
      ),
    );
  }
}

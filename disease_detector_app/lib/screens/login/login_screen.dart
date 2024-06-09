import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/screens/register/register_screen.dart';
import 'package:disease_detector_app/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../config/constants.dart';
import '../../config/themes/app_size.dart';
import '../../config/themes/color.dart';
import '../../firebase_helpers/firebase_auth/firebase_auth_helpers.dart';
import '../../utils/custom_text_theme/custom_text_theme.dart';
import '../../utils/helper/helper_function.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController editingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                "Welcome Back",
                style: dark
                    ? MyTextTheme.darkTextTheme.headlineLarge
                    : MyTextTheme.lightTextTheme.headlineLarge,
              ),
              SizedBox(
                height: AppSize.xl,
              ),
              MyTextFormField(
                dark: dark,
                prefixIcon: Icon(Icons.email_rounded),
                hint: "Email",
                controller: editingController,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                visible: false,
              ),
              SizedBox(
                height: AppSize.xl,
              ),
              MyTextFormField(
                dark: dark,
                prefixIcon: Icon(Iconsax.password_check),
                visible: isPassword,
                suffix: isPassword
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      ),
                hint: "Password",
                controller: passwordController,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
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
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  child: MyButton(
                    dark: dark,
                    name: "Login",
                    onPress: () async {
                      showLoaderDialog(context);
                      if (_formKey.currentState!.validate()) {
                        print("Email: ${editingController.text}");
                        print("Password: ${passwordController.text}");
                        bool isValidated = loginVaildation(
                            editingController.text, passwordController.text);
                        if (isValidated) {
                          bool isLogin = await FirebaseAuthHelper.instance
                              .login(editingController.text,
                                  passwordController.text, context);
                          Navigator.of(context, rootNavigator: true).pop();
                          if (isLogin) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }
                        }
                      }
                    },
                  )),
              SizedBox(
                height: AppSize.md,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                      dark: dark,
                      title: "Sign-In With Google",
                      onPressed: () async {
                        if (await FirebaseAuthHelper.instance
                            .siginWithGoogle(context)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      })),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

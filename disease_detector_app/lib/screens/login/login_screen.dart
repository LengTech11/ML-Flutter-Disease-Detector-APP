import 'package:disease_detector_app/api_service/api/login_api.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/login_model/login_response_model.dart';
import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/screens/register/register_screen.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;
  bool isShowLoading = false;

  LoginApiService loginApiService = LoginApiService();

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final dark = HelperFunctions.isDarkMode(context);
    try {
      LoginResponseModel response =
          await loginApiService.postLogin(email: email, password: password);
      AppConstant.USER_TOKEN = response.token;
      if (!context.mounted) return;
      TokenStorage.saveToken(AppConstant.USER_TOKEN!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } catch (e) {
      HelperFunctions.debug(e.toString());
      Navigator.pop(context);
      showErrorMsg(context, e.toString(), dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: DeviceUtils.getScreenHeight(context) * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: AppSize.appbarHeight),
                  Text(
                    "Welcome Back",
                    style: dark
                        ? MyTextTheme.darkTextTheme.headlineLarge
                        : MyTextTheme.lightTextTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: AppSize.md,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.sm),
                    child: MyTextFormField(
                      dark: dark,
                      prefixIcon: const Icon(Icons.email_rounded),
                      hint: "Email",
                      controller: emailController,
                      keyBoardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      visible: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.sm),
                    child: MyTextFormField(
                      dark: dark,
                      prefixIcon: const Icon(Iconsax.password_check),
                      visible: isPassword,
                      suffix: isPassword
                          ? IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility),
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
                  ),
                  SizedBox(
                    height: AppSize.xl,
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
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      child: MyButton(
                        dark: dark,
                        name: "Login",
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isValidated = loginVaildation(
                                emailController.text, passwordController.text);
                            if (isValidated) {
                              showLoaderDialog(context);
                              await login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                            }
                          }
                        },
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      child: OutlineButton(
                          dark: dark,
                          icon: SvgPicture.asset("assets/icons/google.svg",
                              height: 32.h),
                          title: "Continue with Google",
                          onPressed: () async {
                            if (await FirebaseAuthHelper.instance
                                .siginWithGoogle(context)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            }
                          })),
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
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

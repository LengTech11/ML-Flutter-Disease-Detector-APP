import 'package:disease_detector_app/api_service/api/login_api.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/login_model/login_response_model.dart';
import 'package:disease_detector_app/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:disease_detector_app/screens/register/register_screen.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../config/constants.dart';
import '../../config/themes/app_size.dart';
import '../../config/themes/color.dart';
import '../../utils/helper/helper_function.dart';
import '../../widgets/my_button.dart';

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
    try {
      LoginResponseModel response =
          await loginApiService.postLogin(email: email, password: password);
      AppConstant.userToken = response.token;
      if (!context.mounted) return;
      TokenStorage.saveToken(AppConstant.userToken!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationBarScreen()),
          (route) => false);
    } catch (e) {
      printMe(e.toString());
      Navigator.pop(context);
      showErrorMsg(context, e.toString());
    }
  }

  bool isKeyboardVisible() {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: appPadding,
          child: SizedBox(
            height: DeviceUtils.getScreenHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.appbarHeight),
                Text(
                  AppLocalizations.of(context)?.welcome ?? 'Welcome Back',
                  // style: dark
                  //     ? MyTextTheme.darkTextTheme.headlineLarge
                  //     : MyTextTheme.lightTextTheme.headlineLarge,
                ),
                Image.asset(
                  'assets/logo/logo.png',
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.sm),
                  child: VcTextField(
                    prefixIcon: const Icon(Icons.email_rounded),
                    hint: AppLocalizations.of(context)?.email ?? 'Email',
                    controller: emailController,
                    keyBoardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    visible: false,
                  ),
                ),
                SizedBox(
                  height: AppSize.sm,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.sm),
                  child: VcTextField(
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
                    hint: AppLocalizations.of(context)?.password ?? 'Password',
                    controller: passwordController,
                    keyBoardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  child: MyButton(
                    name: AppLocalizations.of(context)?.login ?? 'Login',
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.dont_have_account ??
                          'Don\'t have account?',
                    ),
                    SizedBox(
                      width: AppSize.xs,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)?.register ?? 'Register',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.xl,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !isKeyboardVisible(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          height: 50.h,
          child: OutlinedButtonWidget(
            borderColor: dark ? AppColor.primary : Colors.white,
            // backgroundColor: dark
            //     ? MyTheme.darkTheme.colorScheme.surface
            //     : MyTheme.darkTheme.colorScheme.surface,
            icon: Icon(
              Iconsax.user,
              color: dark ? AppColor.primary : Colors.white,
            ),
            title: AppLocalizations.of(context)?.login_as_guest ??
                'Continue as Guest',
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationBarScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

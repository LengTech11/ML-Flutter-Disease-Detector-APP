import 'package:disease_detector_app/api_service/api/register_api.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/register_model/register_response_model.dart';
import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../config/constants.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;
  bool isCnfPassword = true;

  bool isShowLoading = false;

  RegisterApiService registerApiService = RegisterApiService();

  Future<void> register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String firstName,
      required String lastName,
      required int age,
      required int gender,
      required BuildContext context}) async {
    final dark = HelperFunctions.isDarkMode(context);
    try {
      RegisterResponseModel response = await registerApiService.postRegister(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phonNumber: phoneNumber,
          age: age,
          gender: gender);
      AppConstant.USER_TOKEN = response.token;
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
              padding: appPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.lg,
                  ),
                  Text(
                    "WELCOME",
                    style: dark
                        ? MyTextTheme.darkTextTheme.headlineLarge
                        : MyTextTheme.lightTextTheme.headlineLarge,
                  ),
                  Text(
                    "Let's Create Your Account",
                    style: dark
                        ? MyTextTheme.darkTextTheme.bodyLarge
                        : MyTextTheme.lightTextTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: AppSize.appbarHeight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) * 0.45,
                        child: MyTextFormField(
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          dark: dark,
                          hint: "First Name",
                          controller: firstNameController,
                          keyBoardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          visible: false,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.sm,
                      ),
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) * 0.45,
                        child: MyTextFormField(
                          dark: dark,
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          hint: "Last Name",
                          controller: lastNameController,
                          keyBoardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          visible: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.lg,
                  ),
                  MyTextFormField(
                    dark: dark,
                    prefixIcon: const Icon(Icons.email_rounded),
                    hint: "Email",
                    controller: emailController,
                    keyBoardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    visible: false,
                  ),
                  SizedBox(
                    height: AppSize.lg,
                  ),
                  MyTextFormField(
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
                    keyBoardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: AppSize.lg,
                  ),
                  MyTextFormField(
                    dark: dark,
                    prefixIcon: const Icon(Iconsax.password_check),
                    visible: isCnfPassword,
                    suffix: isCnfPassword
                        ? IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isCnfPassword = !isCnfPassword;
                              });
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isCnfPassword = !isCnfPassword;
                              });
                            },
                          ),
                    hint: "Confirm Password",
                    controller: confirmController,
                    keyBoardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: AppSize.appbarHeight,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      child: MyButton(
                          dark: dark,
                          name: "Sign Up",
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              final bool isValidated = signUpVaildation(
                                  emailController.text,
                                  passwordController.text,
                                  confirmController.text);
                              if (isValidated) {
                                showLoaderDialog(context);
                                await register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                    phoneNumber: '',
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    age: 0,
                                    gender: 1);
                              }
                            }
                          })),
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
      ),
    );
  }
}

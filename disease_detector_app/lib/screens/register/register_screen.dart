import 'package:disease_detector_app/api_service/api/register_api.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/register_model/register_response_model.dart';
import 'package:disease_detector_app/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
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
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// DropdownMenuEntry labels and values dropdown menu.
enum GenderLabel {
  male(
    label: 'Male',
    value: 1,
  ),
  female(
    label: 'Female',
    value: 2,
  );

  const GenderLabel({required this.label, required this.value});

  final String label;
  final int value;

  String getLocalizedLabel(BuildContext context) {
    switch (this) {
      case GenderLabel.male:
        return AppLocalizations.of(context)?.male ?? 'Male';
      case GenderLabel.female:
        return AppLocalizations.of(context)?.female ?? 'Female';
      default:
        return '';
    }
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;
  bool isCnfPassword = true;

  bool isShowLoading = false;

  RegisterApiService registerApiService = RegisterApiService();

  final TextEditingController genderController = TextEditingController();
  GenderLabel? selectedGender;

  Future<void> register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String firstName,
      required String lastName,
      required String age,
      required int? gender,
      required BuildContext context}) async {
    final dark = HelperFunctions.isDarkMode(context);

    try {
      RegisterResponseModel response = await registerApiService.postRegister(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phonNumber: phoneNumber,
          age: int.parse(age),
          gender: gender);
      AppConstant.userToken = response.token;
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigationBarScreen()),
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
            padding: appPadding,
            child: SizedBox(
              height: DeviceUtils.getScreenHeight(context) * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.register ?? 'Register',
                    // style: dark
                    //     ? MyTextTheme.darkTextTheme.headlineLarge
                    //     : MyTextTheme.lightTextTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: AppSize.md,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) * 0.45,
                        child: VcTextField(
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          hint: AppLocalizations.of(context)?.first_name ??
                              'First Name',
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
                        child: VcTextField(
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          hint: AppLocalizations.of(context)?.last_name ??
                              'Last Name',
                          controller: lastNameController,
                          keyBoardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          visible: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) * 0.45,
                        child: VcTextField(
                          hint: AppLocalizations.of(context)?.age ?? 'Age',
                          controller: ageController,
                          keyBoardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          visible: false,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.xs,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.sm,
                        ),
                        child: DropdownMenu<GenderLabel>(
                          width: DeviceUtils.getScreenWidth(context) * 0.4,
                          controller: genderController,
                          requestFocusOnTap: false,
                          label: Text(
                            AppLocalizations.of(context)?.gender ?? 'Gender',
                            // style: dark
                            //     ? MyTextTheme.darkTextTheme.labelLarge
                            //     : MyTextTheme.lightTextTheme.labelLarge,
                          ),
                          onSelected: (GenderLabel? gender) {
                            setState(
                              () {
                                DeviceUtils.hideKeyboard(context);
                                selectedGender = gender;
                              },
                            );
                          },
                          dropdownMenuEntries: GenderLabel.values
                              .map<DropdownMenuEntry<GenderLabel>>(
                            (GenderLabel gender) {
                              return DropdownMenuEntry<GenderLabel>(
                                value: gender,
                                label: gender.label,
                                style: MenuItemButton.styleFrom(),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  VcTextField(
                    prefixIcon: const Icon(Icons.phone),
                    hint: AppLocalizations.of(context)?.phone_number ??
                        'Phone Number',
                    controller: phoneNumberController,
                    keyBoardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    visible: false,
                  ),
                  VcTextField(
                    prefixIcon: const Icon(Icons.email_rounded),
                    hint: AppLocalizations.of(context)?.email ?? 'Email',
                    controller: emailController,
                    keyBoardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    visible: false,
                  ),
                  VcTextField(
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
                              setState(
                                () {
                                  isPassword = !isPassword;
                                },
                              );
                            },
                          ),
                    hint: AppLocalizations.of(context)?.password ?? 'Password',
                    controller: passwordController,
                    keyBoardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                  VcTextField(
                    prefixIcon: const Icon(Iconsax.password_check),
                    visible: isCnfPassword,
                    suffix: isCnfPassword
                        ? IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  isCnfPassword = !isCnfPassword;
                                },
                              );
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(
                                () {
                                  isCnfPassword = !isCnfPassword;
                                },
                              );
                            },
                          ),
                    hint: AppLocalizations.of(context)?.confirm_password ??
                        'Confirm Password',
                    controller: confirmController,
                    keyBoardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
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
                          name: AppLocalizations.of(context)?.register ??
                              'Register',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              bool isValidated = signUpVaildation(
                                  emailController.text,
                                  passwordController.text,
                                  confirmController.text);
                              if (isValidated) {
                                showLoaderDialog(context);
                                await register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                    phoneNumber: phoneNumberController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    age: ageController.text,
                                    gender: selectedGender?.value);
                              }
                            }
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.already_have_account ??
                            'Already have an account?',
                        // style: dark
                        //     ? MyTextTheme.darkTextTheme.titleMedium
                        //     : MyTextTheme.lightTextTheme.titleMedium,
                      ),
                      SizedBox(
                        width: AppSize.xs,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)?.login ?? 'Login',
                          style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp),
                        ),
                      )
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

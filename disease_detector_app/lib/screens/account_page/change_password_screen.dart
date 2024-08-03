import 'package:disease_detector_app/api_service/api/change_password_api.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/model/change_password/change_password_response_model.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordCotroller = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isShowPassword = true;

  Future<void> changePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    ChangePasswordApiService changePasswordApiService =
        ChangePasswordApiService();
    final dark = HelperFunctions.isDarkMode(context);
    try {
      ChangePasswordResponseModel responseModel =
          await changePasswordApiService.postChangePassword(
              oldPassword: currentPassword,
              password: newPassword,
              confirmPassword: confirmPassword);

      if (responseModel.status == 'success') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password Changed Successfully',
              style: MyTextTheme.lightTextTheme.bodyMedium,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      showErrorMsg(context, e.toString(), dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.change_password ??
                  'Change Password',
              style: dark
                  ? MyTextTheme.darkTextTheme.headlineMedium
                  : MyTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)?.password_tip ??
                  'Your password must be at least 8 characters and should contain letters, number one special character.',
              style: dark
                  ? MyTextTheme.darkTextTheme.bodyLarge
                  : MyTextTheme.lightTextTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            buildCurrentPwdField(context),
            const SizedBox(
              height: 20,
            ),
            MyTextFormField(
              dark: dark,
              hint:
                  AppLocalizations.of(context)?.new_password ?? 'New Password',
              controller: newPasswordController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextFormField(
              dark: dark,
              hint: AppLocalizations.of(context)?.confirm_password ??
                  'Confirm Password',
              controller: confirmPasswordController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              visible: false,
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: buildFloatingButton(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildCurrentPwdField(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return MyTextFormField(
      dark: dark,
      visible: isShowPassword,
      suffix: isShowPassword
          ? IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
            )
          : IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
            ),
      hint:
          AppLocalizations.of(context)?.current_password ?? 'Current Password',
      controller: currentPasswordCotroller,
      keyBoardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  SizedBox buildFloatingButton(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return SizedBox(
      width: DeviceUtils.getScreenWidth(context) * 0.95,
      child: FloatingActionButton(
        onPressed: () {
          changePassword(
            context: context,
            currentPassword: currentPasswordCotroller.text,
            newPassword: newPasswordController.text,
            confirmPassword: confirmPasswordController.text,
          );
        },
        child: Text(
          AppLocalizations.of(context)?.change ?? 'Change',
          style: dark
              ? MyTextTheme.darkTextTheme.labelLarge
              : MyTextTheme.lightTextTheme.labelLarge,
        ),
      ),
    );
  }
}

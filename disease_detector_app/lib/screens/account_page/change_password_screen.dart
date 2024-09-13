import 'package:disease_detector_app/api_service/api/change_password_api.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/model/change_password/change_password_response_model.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
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
    try {
      ChangePasswordResponseModel responseModel =
          await changePasswordApiService.postChangePassword(
              oldPassword: currentPassword,
              password: newPassword,
              confirmPassword: confirmPassword);

      if (responseModel.status == 'success') {
        if (context.mounted) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password Changed Successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showErrorMsg(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // style: dark
              //     ? MyTextTheme.darkTextTheme.headlineMedium
              //     : MyTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)?.password_tip ??
                  'Your password must be at least 8 characters and should contain letters, number one special character.',
              // style: dark
              //     ? MyTextTheme.darkTextTheme.bodyLarge
              //     : MyTextTheme.lightTextTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            buildCurrentPwdField(context),
            const SizedBox(
              height: 20,
            ),
            VcTextField(
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
            VcTextField(
              hint: AppLocalizations.of(context)?.confirm_password ??
                  'Confirm Password',
              controller: confirmPasswordController,
              keyBoardType: TextInputType.text,
              textInputAction: TextInputAction.done,
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
    return VcTextField(
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
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }

  SizedBox buildFloatingButton(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScreenWidth(context) * 0.95,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
        ),
      ),
    );
  }
}

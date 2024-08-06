import 'dart:io';

import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/my_button.dart';
import 'package:disease_detector_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
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

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserProfileProvider userProfileProvider = UserProfileProvider();

  File? image;

  Future<void> initializeField() async {
    await userProfileProvider.getUserProfile();
    final response = userProfileProvider.userProfileModel?.data;
    firstNameController.text = response!.firstName;
    lastNameController.text = response.lastName;
    ageController.text = response.age.toString();
    emailController.text = response.email;
    phoneNumberController.text = response.phoneNumber;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeField();
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Consumer<UserProfileProvider>(
      builder: (BuildContext context, value, child) {
        return Padding(
          padding: appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(Icons.person),
              ),
              const SizedBox(
                height: 18,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit Photo',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
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
                    child: MyTextFormField(
                      dark: dark,
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
              const SizedBox(
                height: 16,
              ),
              MyTextFormField(
                prefixIcon: const Icon(
                  Icons.email,
                ),
                dark: dark,
                hint: AppLocalizations.of(context)?.email ?? 'Email',
                controller: emailController,
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                visible: false,
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextFormField(
                prefixIcon: const Icon(
                  Icons.phone,
                ),
                dark: dark,
                hint: AppLocalizations.of(context)?.phone_number ??
                    'Phone Number',
                controller: phoneNumberController,
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                visible: false,
              ),
              MyButton(
                dark: dark,
                name: 'Edit',
                onPress: () async {
                  showLoaderDialog(context);
                  await value.editUserProfile(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    // age: int.parse(ageController.text),
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                  );
                  await value.getUserProfile();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

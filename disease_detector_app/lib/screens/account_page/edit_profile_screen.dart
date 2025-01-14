// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.user,
  });
  final UserProfileProvider user;

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
  TextEditingController genderController = TextEditingController();

  UserProfileProvider userProfileProvider = UserProfileProvider();

  File? image;
  final ImagePicker _picker = ImagePicker();
  bool isPicked = false;
  int? selectedGender;

  Future<void> initializeField(UserProfileProvider user) async {
    try {
      final response = user.userProfileModel?.data;
      if (response != null) {
        selectedGender = response.gender;
        selectedGender == 1
            ? genderController.text = "Male"
            : genderController.text = "Female";
        firstNameController.text = response.firstName ?? '';
        lastNameController.text = response.lastName ?? '';
        ageController.text = response.age.toString();
        emailController.text = response.email ?? '';
        phoneNumberController.text = response.phoneNumber ?? '';
        if (response.profile != null && response.profile!.isNotEmpty) {
          final profileUrl = 'http://10.0.2.2:8000${response.profile}';

          await downloadImage(profileUrl).then((value) async {
            setState(() {
              image = value;
            });
          });
        } else {
          setState(() {
            image = null;
          });
        }
        printMe('Image path: ${image?.path}');
      } else {
        printMe('Response is null');
      }
    } catch (e) {
      printMe('Error: $e');
    }
  }

  Future<File> replaceImage(String url) async {
    try {
      await deleteImage();

      return await downloadImage(url);
    } catch (e) {
      printMe('Error replacing image: $e');
      rethrow;
    }
  }

  Future<File> downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final file = File('${documentDirectory.path}/profile_picture.jpg');
        file.writeAsBytesSync(response.bodyBytes);
        return file;
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      printMe('Error downloading image: $e');
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/profile_picture.jpg');
      file.deleteSync();
      printMe('Image deleted successfully');
    } catch (e) {
      printMe('Error deleting image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    deleteImage();
    initializeField(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: appPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.transparent,
            foregroundImage: image == null
                ? const AssetImage('assets/images/blank_profile.jpg')
                : isPicked
                    ? FileImage(image!)
                    : NetworkImage(
                        'http://10.0.2.2:8000${widget.user.userProfileModel?.data?.profile}',
                      ) as ImageProvider<Object>,
          ),
          const SizedBox(
            height: 18,
          ),
          TextButton(
            onPressed: () async {
              showModalBottomSheet(
                showDragHandle: true,
                enableDrag: false,
                context: context,
                builder: (context) => Container(
                  width: DeviceUtils.getScreenWidth(context),
                  padding: appPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () async {
                          await openCamera();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        leading: const Icon(
                          Icons.camera_alt,
                          size: 28,
                          color: AppColor.primary,
                        ),
                        title: Text(
                          'Take A Picture',
                          style: TextStyle(fontSize: AppSize.fontLg),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          await pickImage();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        leading: const Icon(
                          Icons.image,
                          size: 28,
                          color: AppColor.primary,
                        ),
                        title: Text(
                          'Choose From Galery',
                          style: TextStyle(fontSize: AppSize.fontLg),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          await deleteImage();
                          setState(() {
                            image = null;
                          });
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        leading: const Icon(
                          Iconsax.trash4,
                          size: 28,
                          color: AppColor.error,
                        ),
                        title: Text(
                          'Remove Profile Picture',
                          style: TextStyle(fontSize: AppSize.fontLg),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              );
            },
            child: Text(
              'Edit Profile Picture',
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 16.sp,
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
                child: VcTextField(
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
                  hint:
                      AppLocalizations.of(context)?.first_name ?? 'First Name',
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
                  hint: AppLocalizations.of(context)?.last_name ?? 'Last Name',
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
                  ),
                  onSelected: (GenderLabel? gender) {
                    setState(
                      () {
                        DeviceUtils.hideKeyboard(context);
                        selectedGender = gender?.value;
                      },
                    );
                  },
                  dropdownMenuEntries:
                      GenderLabel.values.map<DropdownMenuEntry<GenderLabel>>(
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
          const SizedBox(
            height: 16,
          ),
          VcTextField(
            prefixIcon: const Icon(
              Icons.email,
            ),
            hint: AppLocalizations.of(context)?.email ?? 'Email',
            controller: emailController,
            keyBoardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            visible: false,
          ),
          const SizedBox(
            height: 16,
          ),
          VcTextField(
            prefixIcon: const Icon(
              Icons.phone,
            ),
            hint: AppLocalizations.of(context)?.phone_number ?? 'Phone Number',
            controller: phoneNumberController,
            keyBoardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            visible: false,
          ),
          SizedBox(
            height: AppSize.xl,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            width: DeviceUtils.getScreenWidth(context),
            height: 50.h,
            child: VcFilledButton(
              title: 'Update',
              onPressed: () async {
                showLoaderDialog(context);
                await widget.user.editUserProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  age: int.parse(ageController.text),
                  gender: selectedGender ?? 1,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text,
                  image: image ?? File('assets/images/blank_profile.jpg'),
                );
                await widget.user.getUserProfile();
                if (context.mounted) {
                  Navigator.pop(context);
                }
                await deleteImage();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen(),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> openCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          isPicked = true;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(
          () {
            image = File(pickedFile.path);
            isPicked = true;
          },
        );
      }
      if (!mounted) return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}

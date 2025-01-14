import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/account_page/widget/edit_profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    super.key,
    required this.userProvider,
  });

  final UserProfileProvider userProvider;

  @override
  State<ProfileInfo> createState() => _profileInfoState();
}

// ignore: camel_case_types
class _profileInfoState extends State<ProfileInfo> {
  String noImg = "assets/images/blank_profile.jpg";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.userProvider.userProfileModel?.data;
    final profileImageUrl =
        provider?.profile != null && provider!.profile!.isNotEmpty
            ? 'http://10.0.2.2:8000${provider.profile}'
            : noImg;
    final name = widget.userProvider.isGuest
        ? AppLocalizations.of(context)?.guest ?? "Guest"
        : "${provider?.firstName} ${provider?.lastName}";
    final email = widget.userProvider.isGuest
        ? "No Email"
        : provider?.email ?? "No Email";
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              setState(
                () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      insetPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: 320.w,
                        height: 320.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: profileImageUrl == noImg
                                ? AssetImage(noImg) as ImageProvider<Object>
                                : NetworkImage(profileImageUrl)
                                    as ImageProvider<Object>,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 70.h,
              width: 70.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.w,
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: profileImageUrl == noImg
                    ? Image.asset(
                        noImg,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        profileImageUrl,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding * 0.75,
          ),
          Expanded(
            child: SizedBox(
              height: 80.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.userProvider.isGuest
              ? const SizedBox()
              : EditProfileButton(
                  user: widget.userProvider,
                ),
        ],
      ),
    );
  }
}

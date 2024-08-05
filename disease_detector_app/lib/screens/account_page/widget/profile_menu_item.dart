import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({super.key});

  @override
  State<profileInfo> createState() => _profileInfoState();
}

// ignore: camel_case_types
class _profileInfoState extends State<profileInfo> {
  String onImg = "assets/images/blank_profile.jpg";

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Consumer<UserProfileProvider>(
        builder: (context, value, child) {
          final provider = value.userProfileModel?.data;
          final name = value.isGuest
              ? AppLocalizations.of(context)?.guest ?? "Guest"
              : "${provider?.firstName} ${provider?.lastName}";
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  onImg,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(200),
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
                      color: Colors.transparent,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.r),
                    child: Image.asset(
                      onImg,
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
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        value.isGuest
                            ? "No Email"
                            : provider?.email ?? "No Email",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

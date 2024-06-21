import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({super.key});

  @override
  State<profileInfo> createState() => _profileInfoState();
}

// ignore: camel_case_types
class _profileInfoState extends State<profileInfo> {
  String noImg = "https://i.ibb.co/X3WRYSK/FB-IMG-1711252077139.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: appPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Consumer<UserProfileProvider>(
        builder: (context, value, child) {
          final provider = value.userProfileModel?.data;
          final name = "${provider?.firstName} ${provider?.lastName}";
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              insetPadding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(),
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: 320.w,
                                height: 320.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "${noImg}",
                                      )),
                                  borderRadius: BorderRadius.circular(200),
                                ),
                              ),
                            ));
                  });
                  // });
                },
                child: Container(
                    height: 90.h, //140
                    width: 90.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5.w,
                        color: Colors.transparent,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: Image.network(
                        noImg,
                        fit: BoxFit.cover,
                      ),
                    )),
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
                      Text(name,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600)),
                      Text(
                        provider?.email ?? "No Email",
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
        // child: ,
      ),
    );
  }
}

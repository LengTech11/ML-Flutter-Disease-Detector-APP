import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({super.key});

  @override
  State<profileInfo> createState() => _profileInfoState();
}

class _profileInfoState extends State<profileInfo> {

String noImg = "https://firebasestorage.googleapis.com/v0/b/eyes-diseases-detector.appspot.com/o/blank-profile-picture-973460_1280.webp?alt=media&token=b434fcb5-0fab-4e65-9d95-6e1042067e0b";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: appPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Consumer<AppProvider>(
        builder: (ctx, user, _) {
          if (user.getUserInformation == null) {
            user.getUserInfoFirebase();
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // setState(() {
                  if (user.getUserInformation?.profileImg != null) {
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
                                          "${user.getUserInformation?.profileImg}",
                                        )),
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                ),
                              ));
                    });
                  }
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
                    child: user.getUserInformation?.profileImg == ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(45.r),
                            child:
                                SvgPicture.asset("assets/icons/empty_pf.svg"))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: Image.network(
                              "${user.getUserInformation?.profileImg ?? noImg}",
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
                      Text('${user.getUserInformation?.name ?? "No Name"}',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600)),
                      Text(
                        '${user.getUserInformation?.email ?? "No Email"}',
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

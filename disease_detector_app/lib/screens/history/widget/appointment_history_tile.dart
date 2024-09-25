import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentHistoryTile extends StatefulWidget {
  const AppointmentHistoryTile({
    super.key,
    required this.doctorId,
    required this.preferredDate,
    required this.statuse,
    required this.phoneNumber,
  });

  final int doctorId;
  final DateTime preferredDate;
  final String statuse;
  final String phoneNumber;

  @override
  State<AppointmentHistoryTile> createState() => _AppointmentHistoryTileState();
}

class _AppointmentHistoryTileState extends State<AppointmentHistoryTile> {
  DoctorProvider doctorProvider = DoctorProvider();

  @override
  void initState() {
    super.initState();
    doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    doctorProvider.fetchDoctorById(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, value, child) {
        return value.doctor == null
            ? SizedBox(
                width: DeviceUtils.getScreenWidth(context),
                child: const CircularProgressIndicator(),
              )
            : AppointmentHistoryList(
                historyCard: AppointmentItem(
                  widget.statuse.toLowerCase() == 'approved'
                      ? AppColor.success
                      : widget.statuse.toLowerCase() == 'pending'
                          ? AppColor.warning
                          : AppColor.error,
                  id: '',
                  imageUrl: value.doctor!.data!.profilePic,
                  species: DateFormat('h:mm, d MMM yyyy')
                      .format(widget.preferredDate),
                  condition: widget.statuse,
                ),
              );
      },
    );
  }
}

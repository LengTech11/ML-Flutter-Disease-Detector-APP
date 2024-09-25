import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/appointment_provider.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/screens/history/widget/appointment_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AppointmentHistoryWidget extends StatefulWidget {
  const AppointmentHistoryWidget({super.key});

  @override
  State<AppointmentHistoryWidget> createState() =>
      _AppointmentHistoryWidgetState();
}

class _AppointmentHistoryWidgetState extends State<AppointmentHistoryWidget> {
  AppointmentProvider appointmentProvider = AppointmentProvider();
  DoctorProvider doctorProvider = DoctorProvider();
  String imageUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  @override
  void initState() {
    super.initState();

    appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    appointmentProvider.getAppointment();

    doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
  }

  @override
  void dispose() {
    appointmentProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
      builder: (context, value, child) {
        final histories = value.appointment?.data;
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                child: appointmentProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : histories == null
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)?.no_history ??
                                  'No History',
                            ),
                          )
                        : histories.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)?.no_history ??
                                      'No History',
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 8,
                                ),
                                child: ListView.separated(
                                  itemCount:
                                      value.appointment!.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return AppointmentHistoryTile(
                                      doctorId: histories[index].doctorId,
                                      preferredDate:
                                          histories[index].preferredDate,
                                      statuse: histories[index].requestStatus,
                                      phoneNumber: histories[index].phoneNumber,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                ),
                              ),
              ),
            ),
          ],
        );
      },
    );
  }
}

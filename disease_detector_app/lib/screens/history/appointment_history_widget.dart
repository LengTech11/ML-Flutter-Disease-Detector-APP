import 'package:app_ui/app_ui.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentHistoryWidget extends StatefulWidget {
  const AppointmentHistoryWidget({super.key});

  @override
  State<AppointmentHistoryWidget> createState() =>
      _AppointmentHistoryWidgetState();
}

class _AppointmentHistoryWidgetState extends State<AppointmentHistoryWidget> {
  AppointmentProvider appointmentProvider = AppointmentProvider();
  String imageUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  @override
  void initState() {
    super.initState();

    appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    appointmentProvider.getAppointment();
  }

  @override
  void dispose() {
    appointmentProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
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
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            imageUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat('dd-MMMM-yyyy-hh:mm')
                                                    .format(
                                                  histories[index]
                                                      .preferredDate,
                                                ),
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Text(
                                                  histories[index]
                                                      .requestStatus,
                                                  style: dark
                                                      ? const AppDarkTheme()
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.yellow,
                                                          )
                                                      : const AppTheme()
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.yellow,
                                                          ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: histories.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                              ),
              ),
            ),
          ],
        );
      },
    );
  }
}

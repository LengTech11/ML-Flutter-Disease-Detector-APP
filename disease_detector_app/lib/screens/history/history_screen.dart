import 'package:app_ui/app_ui.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/appointment_provider.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
import 'package:disease_detector_app/screens/history/appointment_history_widget.dart';
import 'package:disease_detector_app/screens/history/detection_history_widget.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GetHistoryProvider getHistoryProvider = GetHistoryProvider();
  AppointmentProvider appointmentProvider = AppointmentProvider();

  @override
  void initState() {
    super.initState();

    getHistoryProvider = Provider.of(context, listen: false);
    getHistoryProvider.getHistory();
    _tabController =
        TabController(length: 2, vsync: this); // Ensure correct length
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    getHistoryProvider = Provider.of(context, listen: false);
    getHistoryProvider.getHistory();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetHistoryProvider>(
      builder: (context, getHistoryProvider, child) {
        return Container(
          padding: appPadding,
          child: Column(
            children: [
              TabBar(
                overlayColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                labelStyle: const AppTheme().textTheme.labelLarge,
                dividerColor:
                    Theme.of(context).colorScheme.outline.withOpacity(0.3),
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      width: DeviceUtils.getScreenWidth(context) * 0.4,
                      child: Text(
                        AppLocalizations.of(context)?.history ?? 'History',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      width: DeviceUtils.getScreenWidth(context) * 0.4,
                      child: Text(
                        AppLocalizations.of(context)?.appointment ??
                            'Appointment',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    DetectionHistoryWidget(
                      getHistoryProvider: getHistoryProvider,
                    ),
                    const AppointmentHistoryWidget(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

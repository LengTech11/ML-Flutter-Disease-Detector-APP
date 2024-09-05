import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
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

  @override
  void initState() {
    getHistoryProvider = Provider.of(context, listen: false);
    getHistoryProvider.getHistory();
    _tabController = TabController(length: 1, vsync: this); // Set length to 1
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    getHistoryProvider.getHistory();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: appPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.history ?? 'History',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
              child: Consumer<GetHistoryProvider>(
                builder: (context, value, child) {
                  final histories = value.history;
                  return value.isloading
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
                                    HistoryItem historyItem = HistoryItem(
                                      id: histories[index].id.toString(),
                                      imageUrl: histories[index].imageUrl ?? '',
                                      species:
                                          histories[index].predictedClass ?? '',
                                      condition:
                                          histories[index].confidence ?? '',
                                    );
                                    return HistoryTile(
                                        historyCard: historyItem);
                                  },
                                  itemCount: histories.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

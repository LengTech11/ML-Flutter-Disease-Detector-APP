import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen>
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
                  final history = value.history;
                  return history == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            HistoryItem historyItem = HistoryItem(
                              imageUrl: history[index].imageUrl ?? '',
                              species: history[index].predictedClass ?? '',
                              condition: history[index].confidence ?? '',
                            );
                            return HistoryTile(historyCard: historyItem);
                          },
                          itemCount: value.history!.length,
                          separatorBuilder: (context, index) {
                            HelperFunctions.debug('${history[index].imageUrl}');
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

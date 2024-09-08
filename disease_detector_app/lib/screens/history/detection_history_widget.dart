import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
import 'package:disease_detector_app/widgets/history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetectionHistoryWidget extends StatelessWidget {
  const DetectionHistoryWidget({super.key, this.getHistoryProvider});
  final GetHistoryProvider? getHistoryProvider;

  @override
  Widget build(BuildContext context) {
    final histories = getHistoryProvider?.history;

    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            child: getHistoryProvider!.isloading
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
                                species: histories[index].predictedClass ?? '',
                                condition: histories[index].confidence ?? '',
                              );
                              return HistoryTile(historyCard: historyItem);
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
  }
}

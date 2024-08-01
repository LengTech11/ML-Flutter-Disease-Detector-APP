import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'moreMenu.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key, required this.historyList});
  final List<HistoryItem> historyList;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.historyList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
      itemBuilder: (context, index) {
        HistoryItem plantCard = widget.historyList[index];
        return HistoryTile(
          historyCard: plantCard,
          packed: true,
        );
      },
    );
  }
}

class History extends StatefulWidget {
  const History({super.key, required this.historyList});
  final List<HistoryItem> historyList;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.historyList.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15.sp,
        );
      },
      itemBuilder: (context, index) {
        HistoryItem historyCard = widget.historyList[index];
        return HistoryTile(historyCard: historyCard);
      },
    );
  }
}

class HistoryTile extends StatelessWidget {
  const HistoryTile(
      {super.key, required HistoryItem historyCard, this.packed = false})
      : _historyCard = historyCard;

  final HistoryItem _historyCard;
  final bool packed;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(kDefaultPadding * 0.5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: dark
                ? AppTheme.darkTheme.colorScheme.onError
                : AppTheme.lightTheme.colorScheme.onError,
            blurRadius: kDefaultBorderRaduis,
          ),
        ],
        color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: packed ? 95.h : 130.h, //140
                width: packed ? 95.h : 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://0.0.0.0:8000${_historyCard.imageUrl}'),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                height: packed ? 95.h : 130.h,
                padding: EdgeInsets.symmetric(
                  vertical:
                      packed ? kDefaultPadding * 0.1 : kDefaultPadding * 0.3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _historyCard.species,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding * 0.2,
                          horizontal: kDefaultPadding * 0.5),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRaduis),
                          color: (_historyCard.condition == 'Healthy'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.error)
                              .withOpacity(0.1)),
                      child: Text(
                        _historyCard.condition,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: _historyCard.condition == 'Healthy'
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          packed
              ? const Center()
              : Positioned(
                  right: 0,
                  top: kDefaultPadding * 0.3,
                  child: MoreMenuBox(
                    options: const [
                      MoreItem(text: 'Rename'),
                      MoreItem(
                        text: 'Delete',
                        red: true,
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

class HistoryItem {
  final String imageUrl;
  final String species;
  final String condition;

  const HistoryItem(
      {required this.imageUrl, required this.species, required this.condition});
}

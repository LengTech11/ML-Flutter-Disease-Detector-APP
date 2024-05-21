import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:disease_detector_app/config/constants.dart';

import 'moreMenu.dart';

class HistoryPlants extends StatefulWidget {
  const HistoryPlants({super.key, required this.plantList});
  final List<PlantView> plantList;

  @override
  State<HistoryPlants> createState() => _HistoryPlantsState();
}

class _HistoryPlantsState extends State<HistoryPlants> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.plantList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
      itemBuilder: (context, index) {
        PlantView plantCard = widget.plantList[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          child: Dismissible(
            background: removeWidget(),
            secondaryBackground: addWidget(),
            key: ValueKey(plantCard),
            child: PlantTile(
              plantCard: plantCard,
              packed: true,
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                widget.plantList.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  removeWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          color: Theme.of(context).colorScheme.error),
      child: Text(
        'Remove',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  addWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          color: Theme.of(context).colorScheme.primary),
      child: Text(
        'Add',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyPlants extends StatefulWidget {
  const MyPlants({super.key, required this.plantList});
  final List<PlantView> plantList;

  @override
  State<MyPlants> createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.plantList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 15.sp,
      ),
      itemBuilder: (context, index) {
        PlantView plantCard = widget.plantList[index];
        return ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            child: PlantTile(plantCard: plantCard));
      },
    );
  }
}

class PlantTile extends StatelessWidget {
  const PlantTile(
      {super.key, required PlantView plantCard, this.packed = false})
      : _plantCard = plantCard;

  final PlantView _plantCard;
  final bool packed;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat.yMMMd();
    return Container(
      padding: EdgeInsets.all(kDefaultPadding * 0.6),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context)
              .colorScheme
              .secondaryContainer
              .withOpacity(0.23),
          blurRadius: 6.0.r,
        ),
      ], color: Theme.of(context).colorScheme.background),
      child: Stack(children: [
        Row(
          children: [
            Container(
              height: packed ? 95.h : 130.h, //140
              width: packed ? 95.h : 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(_plantCard.imageUrl),
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
                      packed ? kDefaultPadding * 0.1 : kDefaultPadding * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _plantCard.species,
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
                        color: (_plantCard.condition == 'Healthy'
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.error)
                            .withOpacity(0.1)),
                    child: Text(
                      _plantCard.condition,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: _plantCard.condition == 'Healthy'
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Text(format.format(_plantCard.date)),
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
                ))
      ]),
    );
  }
}

class PlantView {
  final String imageUrl;
  final String species;
  final String condition;
  final DateTime date;
  const PlantView(
      {required this.imageUrl,
      required this.species,
      required this.condition,
      required this.date});
}

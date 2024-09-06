// ignore_for_file: file_names

import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/widgets/buttons.dart';
import 'package:disease_detector_app/widgets/dialog.dart';
import 'package:disease_detector_app/widgets/divider.dart';
import 'package:disease_detector_app/widgets/history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDiseaseCategories extends StatelessWidget {
  final List<HistoryItem> plantList;
  const BuildDiseaseCategories({
    super.key,
    required this.plantList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: ClipRRect(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ButtonWidget(
              text: Text(
                'glaucoma',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              width: 10.w,
            ),
            ButtonWidget(
              text: Text('diabetic_retinopathy',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary)),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              width: 10.w,
            ),
            ButtonWidget(
              text: Text('cataract',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary)),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
            const DividerWidget(),
            ButtonWidget(
              text: Text('Clear All',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialog(
                        onPressed: () {
                          plantList.clear();
                        },
                        title: 'Do you want to clear history?');
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

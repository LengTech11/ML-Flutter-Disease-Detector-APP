import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/widgets/dialog.dart';
import 'package:disease_detector_app/widgets/divider.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PlantView> plantList = [
      PlantView(
          imageUrl: 'assets/images/image_1.jpeg',
          species: 'cataract',
          condition: 'Healthy',
          date: DateTime(2021, 4, 5)),
      ...List.generate(
          10,
          (index) => PlantView(
              imageUrl: 'assets/images/image_2.jpeg',
              species: 'cataract',
              condition: 'Cancer',
              date: DateTime(2020, 12, 1)))
    ];
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding / 2, bottom: kDefaultPadding / 5),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: CustomTabBar(
            tabController: _tabController,
            tabTexts: const ['Eye Diseases', 'History'],
          ),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Column(
                children: [
                  Container(
                    height: 54.h,
                    margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Row(children: [
                      // Expanded(
                      //   child: SearchBar(),
                      // ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                      SortMenuBox(options: const [
                        SortItem(text: 'Date'),
                        SortItem(text: 'Alphabet')
                      ])
                    ]),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                      child: MyPlants(plantList: plantList),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Column(
                children: [
                  Container(
                    height: 54.h,
                    margin: EdgeInsets.only(top: kDefaultPadding),
                    child: Row(children: [
                      // Expanded(
                      //   child: SearchBar(),
                      // ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                      SortMenuBox(options: const [
                        SortItem(text: 'Latest'),
                        SortItem(text: 'Oldest')
                      ])
                    ]),
                  ),
                  Container(
                      height: 34.h,
                      margin:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRaduis),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ButtonWidget(
                                text: Text('glaucoma',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              ButtonWidget(
                                text: Text('diabetic_retinopathy',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              ButtonWidget(
                                text: Text('cataract',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const DividerWidget(),
                              ButtonWidget(
                                  text: Text('Clear All',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                                  color: Theme.of(context).colorScheme.error,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteDialog(
                                              onPressed: () {
                                                plantList.clear();
                                              },
                                              title:
                                                  'Do you want to clear history?');
                                        });
                                  })
                            ]),
                      )),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                      child: HistoryPlants(plantList: plantList),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ]),
    );
  }
}

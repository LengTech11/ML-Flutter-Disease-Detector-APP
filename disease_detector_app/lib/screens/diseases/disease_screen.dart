import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    List<HistoryItem> historyList = [
      HistoryItem(
        imageUrl: 'assets/images/image_1.jpeg',
        species: 'cataract',
        condition: 'Healthy',
        date: DateTime(2021, 4, 5),
      ),
      ...List.generate(
        10,
        (index) => HistoryItem(
          imageUrl: 'assets/images/image_2.jpeg',
          species: 'cataract',
          condition: 'Cancer',
          date: DateTime(2020, 12, 1),
        ),
      ),
    ];
    return Container(
      padding: appPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kDefaultPadding,
          ),
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
              child: HistoryList(historyList: historyList),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/screens/doctor/doctor_screen.dart';
import 'package:disease_detector_app/widgets/eca_listtile.dart';
import 'package:disease_detector_app/widgets/eca_show_btm_sheet.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DiseaseProvider provider = DiseaseProvider();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();
  }

  @override
  void dispose() {
    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VcListTile(
            title: 'Popular Clinics',
            trailing: VcTextButton(
              title: 'View All',
              onPressed: () {
              },
            ),
          ),
          SingleChildScrollView(
            primary: true,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: VcClinicCard(
                    headline: 'Card $index',
                    subHeadline: 'Sub headline',
                    supportingText: 'Supporting text',
                    imageUrl:
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTEsnSc3FKMyZI0jm4nvzJF42tCShDY9de5pHf4FwVw7fo-SSnn',
                    onTap: () {},
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          VcListTile(
            title: 'Popular Doctors',
            trailing: VcTextButton(
              title: 'View All',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorScreen(),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            primary: true,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: VcDoctorCard(
                    headline: 'Card $index',
                    subHeadline: 'Sub headline',
                    supportingText: 'Supporting text',
                    imageUrl:
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTEsnSc3FKMyZI0jm4nvzJF42tCShDY9de5pHf4FwVw7fo-SSnn',
                    onTap: () {},
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          const VcListTile(
            title: 'Disease Documents',
          ),
          Consumer<DiseaseProvider>(
            builder: (context, value, _) {
              return value.isLoading
                  ? const SizedBox(
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.dis?.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var disease = value.dis?.data![index];
                        final documentProvider = Provider.of<DocumentProvider>(
                          context,
                          listen: false,
                        );
                        documentProvider.fetchDocument(disease!.title);

                        return value.dis!.data!.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)
                                          ?.internal_server_error ??
                                      'Internal Server Error',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: EcaListtile(
                                  leading: const Icon(
                                    Icons.visibility,
                                    color: AppColor.primary,
                                  ),
                                  title: Text(disease.title),
                                  onTap: () {
                                    ECABtmSheet().ecaShowBtmSheet(
                                      context: context,
                                      title: disease.title,
                                      description: disease.description,
                                      fileName: disease.title,
                                    );
                                  },
                                ),
                              );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

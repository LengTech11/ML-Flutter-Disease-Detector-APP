import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/clinic_provider.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/screens/clinic/list_clinic_screen.dart';
import 'package:disease_detector_app/screens/doctor/doctor_card.dart';
import 'package:disease_detector_app/screens/doctor/doctor_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
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
  DoctorProvider? doctorProvider;
  ClinicProvider? clinicProvider;

  String doctorImage =
      'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1725408000&semt=ais_hybrid';

  // String clinicImg =
  //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfj5u4Bp_IBF-l7ZX_w_QX7TQKaV1GTi4e_Q&s';

  @override
  void initState() {
    super.initState();

    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();

    clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    clinicProvider!.fetchListClinics();

    doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    doctorProvider!.fetchDotorList();
  }

  @override
  void dispose() {
    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();

    doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    doctorProvider!.fetchDotorList();

    clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    clinicProvider!.fetchListClinics();

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListClinicScreen(
                        clinicProvider: clinicProvider!,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            primary: true,
            scrollDirection: Axis.horizontal,
            child: Consumer<ClinicProvider>(
              builder:
                  (BuildContext context, ClinicProvider value, Widget? child) {
                return value.listClinic == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : value.listClinic!.data != []
                        ? Row(
                            children: List.generate(
                              value.listClinic?.data.length ?? 0,
                              (index) {
                                var clinic = value.listClinic?.data;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: VcClinicCard(
                                    headline:
                                        '${clinic?[index].firstName} ${clinic?[index].lastName}',
                                    subHeadline: clinic?[index].age.toString(),
                                    supportingText: clinic?[index].email,
                                    imageUrl: clinic?[index].profile,
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: DeviceUtils.getScreenWidth(context),
                            padding: appPadding,
                            alignment: Alignment.center,
                            child: Text(
                              'No Doctor Found',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
              },
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
                    builder: (context) {
                      return DoctorScreen(
                        doctorListProvider: doctorProvider!,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            primary: true,
            scrollDirection: Axis.horizontal,
            child: Consumer<DoctorProvider>(
              builder: (context, value, child) {
                var doctors = value.doctors;
                return value.doctors == null
                    ? Container(
                        width: DeviceUtils.getScreenWidth(context),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                    : doctors!.data!.isNotEmpty
                        ? Row(
                            children: List.generate(
                              doctors.data!.length,
                              (index) {
                                var doctor = doctors.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: VcDoctorCard(
                                    headline:
                                        '${doctor!.title}. ${doctor.firstName} ${doctor.lastName}',
                                    subHeadline: doctor.specialist,
                                    supportingText: doctor.description,
                                    imageUrl: doctor.profilePic,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DoctorCardScreen(
                                              doctorProvider: doctorProvider,
                                              id: doctor.id,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: DeviceUtils.getScreenWidth(context),
                            alignment: Alignment.center,
                            padding: appPadding,
                            child: const Text(
                              'No Doctor Found',
                            ),
                          );
              },
            ),
          ),
          const SizedBox(height: 16),
          const VcListTile(
            title: 'Disease Documents',
          ),
          Consumer<DiseaseProvider>(
            builder: (context, value, _) {
              return value.dis == null
                  ? const SizedBox(
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : value.dis!.data!.isEmpty
                      ? Container(
                          width: DeviceUtils.getScreenWidth(context),
                          alignment: Alignment.center,
                          padding: appPadding,
                          child: Text(
                            'No Document Found',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.dis?.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var disease = value.dis?.data![index];
                            final documentProvider =
                                Provider.of<DocumentProvider>(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
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

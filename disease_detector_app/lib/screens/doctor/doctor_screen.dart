import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/screens/doctor/doctor_card.dart';
import 'package:disease_detector_app/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({
    super.key,
    required this.doctorListProvider,
  });

  final DoctorProvider doctorListProvider;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.doctorListProvider = Provider.of(context, listen: false);
    widget.doctorListProvider.fetchDotorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          AppLocalizations.of(context)?.available_doctor ?? 'Available Doctor',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Consumer<DoctorProvider>(
            builder: (context, value, child) {
              return Column(
                children:
                    List.generate(value.doctors?.data?.length ?? 0, (index) {
                  final doctors = value.doctors?.data?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DoctorCardScreen(
                              doctorProvider: widget.doctorListProvider,
                              id: doctors.id,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: appPadding,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SizedBox(
                              width: 160,
                              height: 120,
                              child: CacheImage(
                                imageUrl:
                                    'http://10.0.2.2:8000${doctors?.profilePic}',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${doctors!.firstName} ${doctors.lastName}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Experience: ${doctors.experience.toString()}',
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.telegram,
                                        size: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          ': ${doctors.telegram}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
            // child: Column(),
          ),
        ),
        // child: Padding(
        //   padding: appPadding,
        //   child: Consumer<DoctorProvider>(
        //     builder: (context, value, child) {
        //       var doctors = value.doctors?.data;
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Expanded(
        //             child: GridView.builder(
        //               itemCount: doctors?.length,
        //               gridDelegate:
        //                   const SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 childAspectRatio: 3 / 4,
        //                 crossAxisSpacing: 16,
        //                 mainAxisSpacing: 16,
        //               ),
        //               itemBuilder: (context, index) {
        //                 final doctor = doctors?[index];
        //                 return GestureDetector(
        //                   onTap: () {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => DoctorCardScreen(
        //                           doctorProvider: widget.doctorListProvider,
        //                           id: doctor?.id ?? 0,
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                   child: MouseRegion(
        //                     cursor: SystemMouseCursors.click,
        //                     child: Card(
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(16),
        //                       ),
        //                       elevation: 4,
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(12.0),
        //                         child: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             ClipRRect(
        //                               borderRadius: BorderRadius.circular(12),
        //                               child: Image.asset(
        //                                 'assets/doctor/doctor2.png',
        //                                 height: 100,
        //                                 width: double.infinity,
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                             const SizedBox(height: 8),
        //                             Text(
        //                               '${doctor?.title}. ${doctor?.firstName} ${doctor?.lastName}',
        //                               overflow: TextOverflow.ellipsis,
        //                               style: const TextStyle(
        //                                 fontWeight: FontWeight.bold,
        //                                 fontSize: 16,
        //                               ),
        //                             ),
        //                             const SizedBox(height: 4),
        //                             Text(
        //                               doctor?.specialist ?? 'ok',
        //                               overflow: TextOverflow.ellipsis,
        //                               style: const TextStyle(
        //                                 color: Colors.grey,
        //                               ),
        //                             ),
        //                             const SizedBox(height: 4),
        //                             Text(
        //                               'Experience: ${doctor?.experience} years',
        //                               overflow: TextOverflow.ellipsis,
        //                               style: const TextStyle(
        //                                   // color: Colors.black,
        //                                   ),
        //                             ),
        //                             const SizedBox(height: 4),
        //                             Text(
        //                               'Patient: ${doctor?.patient}',
        //                               overflow: TextOverflow.ellipsis,
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 );
        //               },
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}

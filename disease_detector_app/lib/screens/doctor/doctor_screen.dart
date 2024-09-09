import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/screens/doctor/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({
    super.key,
    required this.doctorListProvider,
  });

  final DoctorProvider doctorListProvider;

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
      body: Padding(
        padding: appPadding,
        child: Consumer<DoctorProvider>(
          builder: (context, value, child) {
            var doctors = value.doctors?.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: doctors!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Wrap(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorCardScreen(
                                  doctorProvider: doctorListProvider,
                                  id: doctor.id,
                                ),
                              ),
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/doctor/doctor2.png',
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${doctor.title}. ${doctor.firstName} ${doctor.lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.specialist,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Experience: ${doctor.experience} years',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          // color: Colors.black,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Patient: ${doctor.patient}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    },
                  ),
                ),
              ],
            );
          },
          // child:,
        ),
      ),
    );
  }
}

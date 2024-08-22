import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/screens/doctor/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> doctors = [
      {
        'name': 'Dr. Serena Gome',
        'specialty': 'Medicine Specialist',
        'experience': '8 Years',
        'patients': '1.08K',
        'image': 'assets/doctor/doctor1.png',
      },
      {
        'name': 'Dr. Asma Khan',
        'specialty': 'Medicine Specialist',
        'experience': '5 Years',
        'patients': '2.7K',
        'image': 'assets/doctor/doctor2.png',
      },
      {
        'name': 'Dr. Kiran Shakia',
        'specialty': 'Medicine Specialist',
        'experience': '5 Years',
        'patients': '2.7K',
        'image': 'assets/doctor/doctor3.png',
      },
      {
        'name': 'Dr. Masuda Khan',
        'specialty': 'Medicine Specialist',
        'experience': '5 Years',
        'patients': '2.7K',
        'image': 'assets/doctor/doctor4.png',
      },
      {
        'name': 'Dr. Johir Raihan',
        'specialty': 'Medicine Specialist',
        'experience': '5 Years',
        'patients': '2.7K',
        'image': 'assets/doctor/doctor5.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        // automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)?.available_doctor ?? 'Available Doctor',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 0.8,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: doctors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            builder: (context) => DoctorCardScreen(),
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
                                    doctor['image'] ??
                                        'assets/images/blank_profile.jpg',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  doctor['name']!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doctor['specialty']!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Experience: ${doctor['experience']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      // color: Colors.black,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Patients: ${doctor['patients']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      // color: Colors.black,
                                      ),
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
        ),
      ),
    );
  }
}

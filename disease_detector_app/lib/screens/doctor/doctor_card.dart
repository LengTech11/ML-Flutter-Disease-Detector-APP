import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/screens/doctor/appointment.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class DoctorCardScreen extends StatefulWidget {
  final DoctorProvider? doctorProvider;
  final int id;

  const DoctorCardScreen({
    super.key,
    this.doctorProvider,
    required this.id,
  });

  @override
  State<DoctorCardScreen> createState() => _DoctorCardScreenState();
}

class _DoctorCardScreenState extends State<DoctorCardScreen> {
  @override
  void initState() {
    super.initState();

    widget.doctorProvider!.fetchDoctorById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoctorProvider>(
        builder: (context, value, child) {
          var doctor = value.doctor;

          return value.doctor == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      '${doctor?.data?.title}. ${doctor?.data?.firstName} ${doctor?.data?.lastName}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [

                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: CacheImage(
                                  imageUrl:
                                      'http://10.0.2.2:8000/storage/${doctor?.data?.profilePic}',
                                ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${doctor?.data?.title}. ${doctor?.data?.firstName} ${doctor?.data?.lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      '${doctor?.data?.specialist}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      '${doctor?.data?.experience} years experience',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VcFilledButton(
                              title: doctor!.data!.phoneNumber,
                              icon: const Icon(Icons.phone),
                              onPressed: () async {
                                final call = Uri.parse(
                                    'tel:+855${doctor.data!.phoneNumber}');
                                url_launcher.launchUrl(call);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.phoneCallColor,
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                              ),
                            ),
                            const SizedBox(width: 20),
                            VcFilledButton(
                              title: 'Telegram',
                              icon: const Icon(Icons.telegram),
                              onPressed: () async {
                                final telegram =
                                    Uri.parse(doctor.data!.telegram);
                                url_launcher.launchUrl(telegram);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.telegramColor,
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        // About Section
                        Card(
                          elevation: 2.0,
                          color:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'About Serena',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  doctor.data!.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn(
                                'Patients', '${doctor.data!.patient}'),
                            _buildStatColumn(
                                'Experience', '${doctor.data!.experience}'),
                            _buildStatColumn(
                                'Available', '${doctor.data!.status}'),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: VcFilledButton(
                            title: 'Book Appointment',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(
                                    doctorId: doctor.data!.id,
                                  ),
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Column _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

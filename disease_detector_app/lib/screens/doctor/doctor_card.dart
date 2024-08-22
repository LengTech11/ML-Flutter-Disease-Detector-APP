import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/widgets/vc_filled_button.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:disease_detector_app/screens/doctor/appointment.dart';

class DoctorCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Dr. Serena Gome',
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture and Name
            const Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                    'assets/doctor/doctor1.png',
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Serena Gome',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Medicine & Heart Specialist',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Good Health Clinic, MBBS, FCPS, Kalamet',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        // SizedBox(height: 5.0),
                        // Row(
                        //   children: List.generate(5, (index) {
                        //     return Icon(
                        //       Icons.star,
                        //       color: Colors.orange,
                        //       size: 16.0,
                        //     );
                        //   }),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VcFilledButton(
                  title: '012344567',
                  icon: Icon(Icons.phone),
                  onPressed: () async {
                    final call = Uri.parse('tel:+85512345678');
                    UrlLauncher.launchUrl(call);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColor.phoneCallColor,
                    foregroundColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                SizedBox(width: 20),
                VcFilledButton(
                  title: 'Telegram',
                  icon: Icon(Icons.telegram),
                  onPressed: () async {
                    final telegram = Uri.parse('https://t.me/hulsambath');
                    UrlLauncher.launchUrl(telegram);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColor.telegramColor,
                    foregroundColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // About Section
            Card(
              elevation: 2.0,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Serena',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('Patients', '1.08K'),
                _buildStatColumn('Experience', '8 Years'),
                _buildStatColumn('Available', 'Status'),
              ],
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: VcFilledButton(
                title: 'Book Appointment',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

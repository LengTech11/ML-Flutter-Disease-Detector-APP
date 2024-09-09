import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/clinic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClinicScreen extends StatelessWidget {
  const ListClinicScreen({super.key, this.clinicProvider});
  final ClinicProvider? clinicProvider;

  static String image =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfj5u4Bp_IBF-l7ZX_w_QX7TQKaV1GTi4e_Q&s';

  @override
  Widget build(BuildContext context) {
    return Consumer<ClinicProvider>(
      builder: (context, value, child) {
        final clinic = value.listClinic;
        return value.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : clinic != null
                ? Scaffold(
                    appBar: AppBar(
                      title: const Text('Clinic List'),
                    ),
                    body: Padding(
                      padding: appPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: clinic.data.isEmpty
                            ? [
                                const Center(
                                  child: Text('No clinic found'),
                                ),
                              ]
                            : List.generate(
                                clinic.data.length,
                                (index) {
                                  final clinic = value.listClinic?.data[index];
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          image,
                                          width: 160,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          cacheWidth: 160,
                                          cacheHeight: 120,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${clinic!.firstName} ${clinic.lastName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const SizedBox(height: 8.0),
                                              Text(
                                                'Age: ${clinic.age.toString()}',
                                              ),
                                              const SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.email_outlined,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    ': ${clinic.email}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text('No Clinic Found'),
                  );
      },
    );
  }
}

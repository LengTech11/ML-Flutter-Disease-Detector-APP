import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/clinic_provider.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClinicScreen extends StatefulWidget {
  const ListClinicScreen({super.key, this.clinicProvider});
  final ClinicProvider? clinicProvider;
  @override
  State<ListClinicScreen> createState() => _ListClinicScreenState();
}

class _ListClinicScreenState extends State<ListClinicScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.clinicProvider?.fetchListClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClinicProvider>(
      builder: (context, value, child) {
        final clinic = value.listClinic;
        return clinic == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : clinic.data != []
                ? Scaffold(
                    appBar: AppBar(
                      title: const Text('Clinic List'),
                    ),
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: appPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            clinic.data.length,
                            (index) {
                              final clinic = value.listClinic?.data[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        width: 160,
                                        height: 120,
                                        child: CacheImage(
                                          imageUrl:
                                              'http://10.0.2.2:8000${clinic?.profile}',
                                        ),
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.email_outlined,
                                                  size: 20,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    ': ${clinic.email}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: DeviceUtils.getScreenWidth(context),
                    alignment: Alignment.center,
                    child: Text(
                      'No clinic found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
      },
    );
  }
}

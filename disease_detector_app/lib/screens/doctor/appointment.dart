import 'package:disease_detector_app/api_service/api/appointment_api.dart';
import 'package:disease_detector_app/model/appointment_model/appointment_model.dart';
import 'package:disease_detector_app/widgets/vc_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({
    super.key,
    required this.doctorId,
  });

  final int doctorId;

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? selectedDate;
  String selectedTime = '';
  TextEditingController phoneController = TextEditingController();

  Future<void> requestAppointment(
    int doctorId,
    String preferredDate,
    String phoneNumber,
  ) async {
    AppointmentApiService requestAppointmentApi = AppointmentApiService();
    try {
      AppointmentModel response =
          await requestAppointmentApi.requestAppointment(
        doctorId: doctorId,
        preferredDate: preferredDate,
        phoneNumber: phoneNumber,
      );
      if (response.requestStatus != null) {
        if (mounted) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password Changed Successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(
        () {
          selectedDate = picked;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)?.appointment ?? 'Appointment',
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              "${DateFormat.MMMM().format(selectedDate ?? DateTime.now())} ${selectedDate?.year}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: VcOutlinedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                title: selectedDate != null
                    ? DateFormat('dd-MMM-yyyy')
                        .format(selectedDate ?? DateTime.now())
                    : 'Pick a Date',
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 20.0),
            Text(
              AppLocalizations.of(context)?.time ?? 'Time Slots',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 15.0,
              runSpacing: 15.0,
              children: ['9:00', '10:30', '1:00', '2:30', '4:00'].map((time) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 70) / 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: selectedTime == time
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: selectedTime == time
                                ? Colors.white
                                : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.phone_number ??
                    'Phone Number',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedTime.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      requestAppointment(
                        widget.doctorId,
                        '${DateFormat('yyyy-MM-dd').format(selectedDate ?? DateTime.now())} $selectedTime',
                        phoneController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)
                                  ?.please_select_time_slot ??
                              'Please select a time slot and enter your phone number'),
                        ),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.confirm_appointment ??
                        'Confirm Appointment',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

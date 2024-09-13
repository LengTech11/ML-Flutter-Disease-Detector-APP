import 'dart:io';

import 'package:dio/dio.dart';
import 'package:disease_detector_app/config/app_config/app_config.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/screens/validate/success_screen.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:disease_detector_app/widgets/eca_listtile.dart';
import 'package:disease_detector_app/widgets/eca_show_btm_sheet.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DiseaseDetectScreen extends StatefulWidget {
  const DiseaseDetectScreen({super.key});

  @override
  State<DiseaseDetectScreen> createState() => _DiseaseDetectScreenState();
}

class _DiseaseDetectScreenState extends State<DiseaseDetectScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _predictedClass;
  double? _confidence;
  Map<String, double> _classProbabilities = {};
  DiseaseProvider provider = DiseaseProvider();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();
  }

  @override
  void dispose() {
    super.dispose();
    provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDisease();
  }

  void show(BuildContext context, String headline, List<Widget> action,
      {String? description}) {
    showDialog(
      context: context,
      builder: (context) => VcDialog(
        headline: headline,
        action: action,
        description: description,
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(
          () {
            _image = File(pickedFile.path);
          },
        );
        await _predictDisease();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _updateDiseaseCount(String title) async {
    const String apiUrl = 'http://0.0.0.0:8000/api/update-disease-count';

    try {
      final dio = Dio();
      final response = await dio.post(
        apiUrl,
        data: {'title': title},
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Disease count updated successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to update disease count: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating disease count: $e');
      }
    }
  }

  Future<void> _updateUserCount() async {
    const String apiUrl = 'http://0.0.0.0:8000/api/user-count';

    // Get the user token
    String? userToken = AppConstant.userToken;

    if (userToken == null) {
      if (kDebugMode) {
        print('User is not authenticated');
      }
      return;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
            response.data as Map<String, dynamic>;
        if (kDebugMode) {
          print(jsonResponse['message']);
        }
      } else {
        throw Exception('Failed to update user count: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user count: $e');
      }
    }
  }

  Future<void> _predictDisease() async {
    if (_image == null) return;

    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      final dio = Dio();
      final formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(_image!.path),
        },
      );

      final response = await dio.post(
        AppConfig.predictApiUrl,
        data: formData,
      );

      if (response.statusCode == 200) {
        printMe(response.data.toString());
        setState(
          () {
            _predictedClass = response.data['Predicted Class'].toString();
            _confidence = response.data['Confidence'];
            _classProbabilities =
                Map<String, double>.from(response.data['Class Probabilities']);
          },
        );
        // Call the method to update disease count
        if (_predictedClass != null) {
          await _updateDiseaseCount(_predictedClass!);
          await _updateUserCount();
        }
        // ignore: use_build_context_synchronously
        _showPredictionBottomSheet(context);
      } else {
        printMe(response.data.toString());
        setState(
          () {
            _predictedClass = 'Failed to predict';
            _confidence = null;
            _classProbabilities = {};
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error predicting disease: $e');
      }
      setState(
        () {
          _predictedClass = 'Failed to predict';
          _confidence = null;
          _classProbabilities = {};
        },
      );
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  Future<bool> savePrediction(String predictedClass, double confidence) async {
    const String apiUrl = 'http://0.0.0.0:8000/api/save-history';

    String? token = AppConstant.userToken;

    if (token == null) {
      if (kDebugMode) {
        print('User is not authenticated');
      }
      return false;
    }

    try {
      final dio = Dio();
      final formData = FormData.fromMap(
        {
          'predicted_class': predictedClass,
          'confidence': confidence,
          'image':
              await MultipartFile.fromFile(_image!.path, filename: 'image.jpg'),
        },
      );

      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Prediction saved successfully');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to save prediction: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving prediction: $e');
      }
      return false;
    }
  }

  void _showPredictionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.none,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          final dark = HelperFunctions.isDarkMode(context);
          List<Widget> classProbabilityWidgets =
              _classProbabilities.entries.map(
            (entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${entry.key}: ',
                              ),
                              TextSpan(
                                text:
                                    '${(entry.value * 100).toStringAsFixed(2)}%',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: entry.value,
                                backgroundColor: Colors.grey[200],
                                color: Colors.blue,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${(entry.value * 100).toStringAsFixed(0)}%',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 2,
                  ),
                ],
              );
            },
          ).toList();

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dark ? Colors.grey[850] : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prediction Result:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: 'Disease: '),
                              TextSpan(
                                text: _predictedClass ?? 'Unknown',
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 20,
                          thickness: 2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(text: 'Confidence: '),
                                  TextSpan(
                                      text: _confidence != null
                                          ? '${(_confidence! * 100).toStringAsFixed(2)}%'
                                          : 'N/A'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: _confidence ?? 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.green,
                                                Colors.blueAccent
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.grey,
                          height: 20,
                          thickness: 2,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Class Probabilities:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...classProbabilityWidgets,
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.ok,
                              minimumSize: const Size(double.infinity, 50),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Close',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              minimumSize: const Size(double.infinity, 50),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              _showConfirmationDialog(context);
                            },
                            child: const Text(
                              'Save Prediction',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
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
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirm_save),
        content: Text(AppLocalizations.of(context)!.do_you_want_to_save),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              // Check authentication status and show a snackbar if not authenticated
              String? token = AppConstant.userToken;
              if (token == null) {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                ); // Close all dialogs
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!
                          .guest_needs_to_signup_or_login,
                    ),
                  ),
                );
              } else {
                // Call the function to save the prediction
                if (_predictedClass != null && _confidence != null) {
                  bool success = await savePrediction(
                    _predictedClass!,
                    _confidence!,
                  );
                  if (context.mounted) {
                    // Close all dialogs
                    Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                    );
                  }
                  if (success) {
                    if (context.mounted) {
                      // Navigate to SuccessScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(),
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .failed_to_save_prediction),
                        ),
                      );
                    }
                  }
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildContent(context),
      ),
    );
  }

  Widget buildListDiseases(BuildContext context) {
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    return Consumer<DiseaseProvider>(
      builder: (context, value, _) {
        return value.dis == null
            ? SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.internal_server_error ??
                        'Internal Server Error',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: value.dis?.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var disease = value.dis?.data![index];
                  documentProvider.fetchDocument(disease!.title);
                  return value.dis!.data!.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Consumer<DocumentProvider>(
                            builder: (context, doc, _) {
                              return EcaListtile(
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
                              );
                            },
                          ),
                        );
                },
              );
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUploadImageContent(context),
          const SizedBox(height: 20),
          buildDescription(context),
          const SizedBox(height: 20),
          buildListDiseases(context),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget buildUploadImageContent(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildUploadImageTitle(context),
        const SizedBox(height: 20),
        buildDottedBorder(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildUploadImageTitle(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.note_alt_outlined,
        size: 35,
        color: Color(0xFF3F51B5),
      ),
      title: Text(
        AppLocalizations.of(context)?.upload_eye_disease_image ??
            'Upload Image',
      ),
    );
  }

  Widget buildDottedBorder() {
    return DottedBorder(
      dashPattern: const [9, 9],
      color: const Color(0xFF3F51B5),
      strokeWidth: 1.5,
      child: Container(
        height: 260,
        width: 260,
        color: Colors.white,
        child: buildUploadImageButton(context),
      ),
    );
  }

  Widget buildUploadImageButton(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              height: 260,
              width: 260,
              color: Theme.of(context).colorScheme.tertiaryFixed,
              child: _image == null
                  ? const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 50,
                      color: Color(0xFF3F51B5),
                    )
                  : Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const Positioned(
          bottom: 40,
          left: 170,
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 35,
            color: Color(0xFF3F51B5),
          ),
        ),
      ],
    );
  }

  Widget buildDescription(BuildContext context) {
    return Text(
      AppLocalizations.of(context)?.after_upload_info ?? 'Disease Description',
    );
  }
}

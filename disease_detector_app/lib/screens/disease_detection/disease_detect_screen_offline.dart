import 'dart:io';
import 'dart:typed_data';

import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/screens/disease_detection/widgets/class_probabilities.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/service.dart';

class DiseaseDetectScreenOffline extends StatefulWidget {
  const DiseaseDetectScreenOffline({super.key});

  @override
  State<DiseaseDetectScreenOffline> createState() =>
      _DiseaseDetectScreenState();
}

class _DiseaseDetectScreenState extends State<DiseaseDetectScreenOffline> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  DiseaseProvider provider = DiseaseProvider();

  ModelService modelService = ModelService();
  List? _prediction;

  double? confidence;
  String? name;

  double diabeticConfidence = 0;
  double normalConfidence = 0;
  double glaucumaConfidence = 0;
  double cataractConfidence = 0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    loadModel();
  }

  void checkDisease(
    double diabetic,
    double normal,
    double glaucuma,
    double cataract,
  ) {
// Finding the maximum value
    confidence = diabetic;

    if (normal > confidence!) {
      confidence = normal;
    }
    if (glaucuma > confidence!) {
      confidence = glaucuma;
    }
    if (cataract > confidence!) {
      confidence = cataract;
    }
  }

  Future<void> loadModel() async {
    await modelService.loadModel();
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

  Future<void> predictImage(File? image) async {
    if (image != null) {
      // Load image bytes from an asset or other source
      Uint8List imageBytes = await File(image.path).readAsBytes();

      try {
        List result = await modelService.runModelOnImage(imageBytes);

        setState(() {
          _prediction = result;
        });

        diabeticConfidence = _prediction?[0][0] * 100;
        normalConfidence = _prediction?[0][1] * 100;
        glaucumaConfidence = _prediction?[0][2] * 100;
        cataractConfidence = _prediction?[0][3] * 100;

        checkDisease(
          diabeticConfidence,
          normalConfidence,
          glaucumaConfidence,
          cataractConfidence,
        );

        if (confidence == diabeticConfidence) {
          name = 'Diabetic Retinopathy';
        } else if (confidence == normalConfidence) {
          name = 'Normal';
        } else if (confidence == glaucumaConfidence) {
          name = 'Glaucuma';
        } else {
          name = 'Cataract';
        }

        if (!mounted) return;
        _showPredictionBottomSheet(context);
      } catch (e) {
        if (!mounted) return;
        show(
          context,
          'Error',
          [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
          description: 'Error predicting image: $e',
        );
      }
    }
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
        await predictImage(_image);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
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
                                text: name ?? 'Unknown',
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.outline,
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
                                    text: confidence != null
                                        ? '${confidence!.toStringAsFixed(2)}%'
                                        : 'N/A',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
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
                                        widthFactor: confidence! / 100,
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
                        Divider(
                          color: Theme.of(context).colorScheme.outline,
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
                        ClassProbabilities(
                          name: 'Normal',
                          confidence: normalConfidence,
                        ),
                        const SizedBox(height: 8),
                        ClassProbabilities(
                          name: 'Diabetic Retinopathy',
                          confidence: diabeticConfidence,
                        ),
                        const SizedBox(height: 8),
                        ClassProbabilities(
                          name: 'Glaucuma',
                          confidence: glaucumaConfidence,
                        ),
                        const SizedBox(height: 8),
                        ClassProbabilities(
                          name: 'Cataract',
                          confidence: cataractConfidence,
                        ),
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
                              backgroundColor: AppColor.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildContent(context),
      ),
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
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget buildUploadImageContent(BuildContext context) {
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
        color: Theme.of(context).colorScheme.outline,
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

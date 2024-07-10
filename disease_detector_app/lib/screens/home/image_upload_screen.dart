import 'dart:io';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class ImageUploadScreen extends StatefulWidget {
  ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _predictedClass;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDocument();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _predictDisease();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _predictDisease() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_image!.path),
      });
      final response =
          await dio.post('http://127.0.0.1:5000/predict', data: formData);

      if (response.statusCode == 200) {
        setState(() {
          _predictedClass = response.data['Predicted Class'].toString();
          _confidence = response.data['Confidence'];
        });
        _showPredictionBottomSheet();
      } else {
        setState(() {
          _predictedClass = 'Failed to predict';
          _confidence = null;
        });
      }
    } catch (e) {
      setState(() {
        _predictedClass = 'Failed to predict';
        _confidence = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPredictionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.3, // Half screen on initial display
        minChildSize: 0.3, // Minimum screen size
        maxChildSize: 1.0, // Full screen on drag
        expand: false, // Don't expand automatically
        builder: (context, scrollController) {
          return Container(
            width: double.infinity, // Ensure sheet spans entire width
            alignment: Alignment.center, // Center content horizontally
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prediction Result',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Class: ${_predictedClass ?? 'Unknown'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Confidence: ${_confidence != null ? (_confidence! * 100).toStringAsFixed(2) + '%' : 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
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
          const SizedBox(height: 65),
          buildUploadImageContent(context),
          const SizedBox(height: 20),
          buildDescription(context),
          const SizedBox(height: 20),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget buildUploadImageContent(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          leading: const Icon(
            Icons.note_alt_outlined,
            size: 35,
            color: Color(0xFF3F51B5),
          ),
          title: Text(
            'Please upload an image of the eye disease here',
            style: dark
                ? MyTextTheme.darkTextTheme.labelLarge
                : MyTextTheme.lightTextTheme.labelLarge,
          ),
        ),
        const SizedBox(height: 20),
        DottedBorder(
          dashPattern: const [9, 9],
          color: const Color(0xFF3F51B5),
          strokeWidth: 1.5,
          child: Container(
            height: 260,
            width: 260,
            color: Colors.white,
            child: buildUploadImageButton(context),
          ),
        ),
        const SizedBox(height: 30),
      ],
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
              color: Theme.of(context).colorScheme.secondary,
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
    final dark = HelperFunctions.isDarkMode(context);
    return Text(
      'After uploading the image, you can view information about various eye diseases below:',
      style: dark
          ? MyTextTheme.darkTextTheme.labelLarge
          : MyTextTheme.lightTextTheme.labelLarge,
    );
  }
}

import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageUploadScreen extends StatefulWidget {
  ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final provider = Provider.of<DiseaseProvider>(context, listen: false);
    provider.fetchDocument();
  }

  final List<String> products = [
    'glaucoma',
    'cataract',
    'diabetic_retinopathy',
    'normal'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
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
          buildProductList(context),
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
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PdfScreen(id: 1)));
            },
            child: Container(
              height: 260,
              width: 260,
              color: Theme.of(context).colorScheme.secondary,
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
        )
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

  Widget buildProductList(BuildContext context) {
    return Consumer<DiseaseProvider>(
      builder: (context, value, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.dis!.data.length,
          itemBuilder: (context, index) {
            final dis = value.dis!.data[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.remove_red_eye_sharp,
                    color: Color(0xFF3F51B5)),
                title: Text(dis.title),
                subtitle: Text(dis.description),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.5, // Half screen on initial display
                      minChildSize: 0.3, // Minimum screen size
                      maxChildSize: 1.0, // Full screen on drag
                      expand: false, // Don't expand automatically
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(height: 16.0),
                                Text(
                                  'This is a bottom sheet',
                                  style: TextStyle(fontSize: 24.0),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'You can pull this sheet to the top to expand it to full screen.',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(height: 16.0),
                                Container(
                                  height: 200,
                                  color: Colors.blue[100],
                                  child:
                                      Center(child: Text('Scrollable content')),
                                ),
                                Container(
                                  height: 200,
                                  color: Colors.blue[200],
                                  child:
                                      Center(child: Text('Scrollable content')),
                                ),
                                Container(
                                  height: 200,
                                  color: Colors.blue[300],
                                  child:
                                      Center(child: Text('Scrollable content')),
                                ),
                                Container(
                                  height: 200,
                                  color: Colors.blue[400],
                                  child:
                                      Center(child: Text('Scrollable content')),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      // child: ,
    );
  }
}

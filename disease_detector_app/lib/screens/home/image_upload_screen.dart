import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageUploadScreen extends StatelessWidget {
  ImageUploadScreen({Key? key}) : super(key: key);

  final List<String> products = [
    'glaucoma',
    'cataract',
    'diabetic_retinopathy',
    'normal'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 65),
          buildUploadImageContent(),
          const SizedBox(height: 20),
          buildDescription(),
          const SizedBox(height: 20),
          buildProductList(),
        ],
      ),
    );
  }

  Widget buildUploadImageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ListTile(
          leading: Icon(
            Icons.note_alt_outlined,
            size: 35,
            color: Color(0xFF3F51B5),
          ),
          title: Text(
            'Please upload an image of the eye disease here',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            child: buildUploadImageButton(),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildUploadImageButton() {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 260,
            width: 260,
            color: Colors.grey[200],
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

  Widget buildDescription() {
    return Text(
      'After uploading the image, you can view information about various eye diseases below:',
      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
    );
  }

  Widget buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.remove_red_eye_sharp,
                color: Color(0xFF3F51B5)),
            title: Text(products[index]),
            subtitle: Text('This is a description of ${products[index]}.'),
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
                              child: Center(child: Text('Scrollable content')),
                            ),
                            Container(
                              height: 200,
                              color: Colors.blue[200],
                              child: Center(child: Text('Scrollable content')),
                            ),
                            Container(
                              height: 200,
                              color: Colors.blue[300],
                              child: Center(child: Text('Scrollable content')),
                            ),
                            Container(
                              height: 200,
                              color: Colors.blue[400],
                              child: Center(child: Text('Scrollable content')),
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
  }
}

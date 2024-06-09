import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageUploadScreen extends StatelessWidget {
  const ImageUploadScreen({super.key});

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
            'Please upload an image of the plant disease here',
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
      'After uploading the image, you can view our products below:',
      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
    );
  }

  Widget buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              radius: 25,
              child: Icon(Icons.account_circle, size: 25),
            ),
            title: Text('Product ${index + 1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('This is a description of product ${index + 1}.'),
                const SizedBox(height: 10),
                Image.asset('assets/images/image_2.jpeg'),
              ],
            ),
          ),
        );
      },
    );
  }
}

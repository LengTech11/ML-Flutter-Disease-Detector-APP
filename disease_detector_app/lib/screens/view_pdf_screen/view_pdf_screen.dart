import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key, required this.id});
  final int id;

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<DocumentProvider>(context, listen: false);
    provider.fetchDocument(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DocumentProvider>(
        builder: (context, value, _) {
          final doc = value.doc?.url;
          return doc == null
              ? Center(child: CircularProgressIndicator())
              : SfPdfViewer.network(
                  'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');
        },
        // child:
      ),
    );
  }
}

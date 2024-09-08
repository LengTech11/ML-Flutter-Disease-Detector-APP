import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/screens/pdf_screen/pdf_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ECABtmSheet {
  DocumentProvider documentProvider = DocumentProvider();
  ScrollController scrollController = ScrollController();
  void ecaShowBtmSheet({
    required BuildContext context,
    required String title,
    String? description,
    String? fileUrl,
    String? fileName,
  }) {
    documentProvider = Provider.of<DocumentProvider>(context, listen: false);
    documentProvider.fetchDocument(fileName!);

    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      context: (context),
      isScrollControlled: true,
      clipBehavior: Clip.none,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5, // Half screen on initial display
        minChildSize: 0.5, // Minimum screen size
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) {
          return SizedBox(
            width: DeviceUtils.getScreenWidth(context),
            child: Padding(
              padding: appPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(title),
                    ),
                  ),
                  Text(
                    description!,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Document'),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer<DocumentProvider>(
                    builder: (context, value, _) {
                      if (value.doc == null || value.doc!.data.isEmpty) {
                        return const Center(
                          child: Text('No document found'),
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                            itemCount: value.doc!.data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  printMe('file url: $fileUrl');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PDFScreen(
                                        url: value.doc?.data[index].url ??
                                            'null',
                                        title:
                                            value.doc?.data[index].fileName ??
                                                'No title',
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/PDF_file_icon.svg'),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Text(
                                        value.doc?.data[index].fileName ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Divider(),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ECAShowBtmSheet extends StatelessWidget {
  const ECAShowBtmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

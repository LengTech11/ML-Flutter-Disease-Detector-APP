import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/screens/pdf_screen/pdf_screen.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ECABtmSheet {
  ECABtmSheet._();
  ScrollController scrollController = ScrollController();
  static void ecaShowBtmSheet(
      {required BuildContext context,
      required String title,
      String? description,
      String? fileUrl,
      String? fileName}) {
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
          final dark = HelperFunctions.isDarkMode(context);
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
                      child: Text(
                        title,
                        style: dark
                            ? MyTextTheme.darkTextTheme.titleLarge
                            : MyTextTheme.lightTextTheme.titleLarge,
                      ),
                    ),
                  ),
                  Text(
                    description!,
                    style: dark
                        ? MyTextTheme.darkTextTheme.titleMedium
                        : MyTextTheme.lightTextTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Document',
                    style: dark
                        ? MyTextTheme.darkTextTheme.titleLarge
                        : MyTextTheme.lightTextTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      printMe('file url: $fileUrl');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(
                                    url: fileUrl ?? 'none',
                                    title: fileName,
                                  )));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icons/PDF_file_icon.svg'),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          fileName!,
                          style: dark
                              ? MyTextTheme.darkTextTheme.bodyMedium
                              : MyTextTheme.lightTextTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
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

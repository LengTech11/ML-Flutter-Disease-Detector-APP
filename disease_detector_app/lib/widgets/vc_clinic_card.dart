import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class VcClinicCard extends StatefulWidget {
  const VcClinicCard({
    super.key,
    required this.headline,
    required this.subHeadline,
    required this.supportingText,
    required this.imageUrl,
    required this.onTap,
  });

  final String? headline;
  final String? subHeadline;
  final String? supportingText;
  final String? imageUrl;
  final void Function() onTap;

  @override
  State<VcClinicCard> createState() => _VcClinicCardState();
}

class _VcClinicCardState extends State<VcClinicCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      overlayColor: WidgetStateProperty.all(
        Theme.of(context).colorScheme.tertiaryFixedDim.withOpacity(0.12),
      ),
      onTap: widget.onTap,
      child: Ink(
        width: DeviceUtils.getScreenWidth(context) * 0.65,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surfaceDim,
              blurRadius: 12,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Ink(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                // image: DecorationImage(
                //   image: CachedNetworkImageProvider(child: CacheImage(image: widget.imageUrl)),
                // ),
              ),
              child: CacheImage(imageUrl: widget.imageUrl),
            ),
            Ink(
              padding: appPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.headline ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subHeadline ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.supportingText ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

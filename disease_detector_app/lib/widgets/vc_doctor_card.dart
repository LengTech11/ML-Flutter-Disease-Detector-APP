import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter/material.dart';

class VcDoctorCard extends StatefulWidget {
  const VcDoctorCard({
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
  State<VcDoctorCard> createState() => _VcClinicCardState();
}

class _VcClinicCardState extends State<VcDoctorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      overlayColor: WidgetStateProperty.all(
        Theme.of(context).colorScheme.tertiaryFixedDim.withOpacity(0.12),
      ),
      onTap: widget.onTap,
      child: Ink(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Ink(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/doctor/doctor1.png'),
                  fit: BoxFit.cover,
                ),
              ),
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

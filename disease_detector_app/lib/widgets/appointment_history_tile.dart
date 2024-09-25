import 'package:disease_detector_app/config/constants.dart';
// import 'package:disease_detector_app/config/themes/theme.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
// import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppointmentHistoryList extends StatelessWidget {
  const AppointmentHistoryList({
    super.key,
    required AppointmentItem historyCard,
    this.packed = false,
  }) : _historyCard = historyCard;

  final AppointmentItem _historyCard;
  final bool packed;

  Future<void> _deletePrediction(BuildContext context, String id) async {
    try {
      printMe('Attempting to delete prediction with ID: $id');
      await Provider.of<GetHistoryProvider>(context, listen: false)
          .deletePrediction(id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.delete_history_success),
          ),
        );
      }
      if (context.mounted) {
        await Provider.of<GetHistoryProvider>(context, listen: false)
            .getHistory();
      }
    } catch (e) {
      printMe('Error deleting prediction: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.delete_history_failed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_historyCard.id), // Unique key for each item
      direction: DismissDirection.endToStart, // Swipe from right to left
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.sp,
        ),
      ),
      confirmDismiss: (direction) async {
        // Ask for confirmation before deleting
        return await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirm_delete),
            content: Text(AppLocalizations.of(context)!.delete_history),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        _deletePrediction(context, _historyCard.id);
      },
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding * 0.5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
        ),
        child: Row(
          children: [
            Container(
              height: packed ? 95.h : 130.h,
              width: packed ? 95.h : 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'http://10.0.2.2:8000/storage/${_historyCard.imageUrl}',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Container(
              height: packed ? 95.h : 130.h,
              padding: EdgeInsets.symmetric(
                vertical:
                    packed ? kDefaultPadding * 0.1 : kDefaultPadding * 0.3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      _historyCard.species,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding * 0.2,
                        horizontal: kDefaultPadding * 0.5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _historyCard.color ??
                            Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                      color: (_historyCard.color ??
                              Theme.of(context).colorScheme.primary)
                          .withOpacity(0.1),
                    ),
                    child: Text(
                      _historyCard.condition,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _historyCard.color ?? Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
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

class AppointmentItem {
  final String id;
  final String imageUrl;
  final String species;
  final String condition;
  final Color? color;

  const AppointmentItem(
    this.color, {
    required this.id,
    required this.imageUrl,
    required this.species,
    required this.condition,
  });
}

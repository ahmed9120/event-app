import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore.dart';
import 'package:event_app/models/category_data.dart';
import 'package:event_app/models/event_task_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../settings_provider.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key, required this.eventTaskData});

  final EventTaskData eventTaskData;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider= Provider.of<SettingsProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(eventTaskData.eventCategoryImg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: provider.isDark()?ColorPallete.darkBackgroundColor:Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateFormat(" dd \nMMM").format(eventTaskData.selectedDate),
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: provider.isDark()?ColorPallete.darkBackgroundColor:Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventTaskData.eventTitle,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Bounceable(
                  onTap: () {
                    eventTaskData.isFavourite =
                        !eventTaskData.isFavourite;
                    FirebaseFirestoreUtils.updateEventTask(
                      eventTaskData: eventTaskData,
                    );
                  },
                  child: Icon(
                    eventTaskData.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 30,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

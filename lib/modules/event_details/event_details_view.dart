import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore.dart';
import 'package:event_app/models/event_task_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_buttom.dart';
import '../settings_provider.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var provider = Provider.of<SettingsProvider>(context);
    final args =ModalRoute.of(context)!.settings.arguments as Map;
    String eventTextLocation= args["eventTextLocation"];
    EventTaskData eventTaskData= args["eventDetails"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        actions: [
          Bounceable(
            onTap: () {
              Navigator.pushNamed(context, PageRoutesName.eventCreation, arguments: eventTaskData);
            },
            child: Icon(
              Icons.edit_calendar_outlined,
              color: theme.primaryColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          Bounceable(
            onTap: () {
              FirebaseFirestoreUtils.deleteEventTask(eventTaskData: eventTaskData).then((success){
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.delete_outlined,
              color: ColorPallete.deleteRedColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                eventTaskData.eventCategoryImg,
                height: 203,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              eventTaskData.eventTitle,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: theme.primaryColor,
              ),
            ),
            SizedBox(height: 16),
            CustomButtom(
              onTap: () {},
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat("dd MMMM yy").format(eventTaskData.selectedDate), style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),),
                        Text(eventTaskData.selectedTime, style: theme.textTheme.bodyMedium!.copyWith(color: ColorPallete.generalTextColor),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            CustomButtom(
              onTap: () {},
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.my_location,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      eventTextLocation,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.primaryColor,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Description", style: theme.textTheme.bodyMedium,),
            SizedBox(height: 16),
            Text(eventTaskData.eventDescription,style: theme.textTheme.bodyMedium,),
    ],
        ),
      ),
    );
  }
}
